//
//  QRCodeController.swift
//  dagda
//
//  Created by remy DEME on 13/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

enum QRCODETYPE : String {
    case known = "known"
    case unknown = "uknown"
    case notValid = "notValid"
}



protocol QRCodeControllerInput {
    func displayDescription(description: [String : AnyObject]?)
    func displayAddDescription()
    func noDescritpionForRoom()
    func videoExist(state: Bool)
}

protocol QRCodeControllerOutput {
    func fetchDescriptionIfExist(room: String)
    func downloadVideoDescription(roomName: String)
}



class QRCodeController : UIViewController, AVCaptureMetadataOutputObjectsDelegate,  AVSpeechSynthesizerDelegate  {
  
    // interactor
    
    var output : QRCodeControllerOutput!
    
    // image video attribute
    var captureSession : AVCaptureSession? // to perform a real time capture cession
    var videoPrewLayer : AVCaptureVideoPreviewLayer?
    var captureMetaDataOutput : AVCaptureMetadataOutput!
    var input : AVCaptureInput!
    var qrCodeFrameView : UIView!
    var device : AVCaptureDevice!
    var timeTable : TimeTableController!
    var editDescription: EditDescriptionController!
    var topController : QRCodeHomeController!
    var qrCodeInfo : [String:String]!
    
    var speech = ""
    // speech synthetizer
    
    let speechSynthetizer = AVSpeechSynthesizer()
    
    
    
    override func viewDidLoad() {
        setUp()
        QRCodeConfigure.instance.configure(controller: self) // configure VIPER instance
    }
    
    func setUp(){
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = true
        tabBarController?.tabBar.isHidden = false
        timeTable = TimeTableController()
        captureSession = AVCaptureSession()
        setUpGesture()
        do {
            try  setCamera()
        }catch let err {
            print(err.localizedDescription)
        }

    }
    
    func getCaptureDevice() throws {
        let session = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back)
        let cameras = (session.devices.compactMap { $0 })
        if cameras.isEmpty { throw VideoControllerError.noCamerasAvailable }
        
        for camera in cameras {
            
            if camera.position == .back {
                device = camera
                try camera.lockForConfiguration()
                camera.focusMode = .autoFocus
                camera.unlockForConfiguration()
            }
        }
    }
 
    
    func setCamera() throws {
        
        do{
            try getCaptureDevice()
        }catch let err {
            print (err.localizedDescription)
        }
      
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            input = try AVCaptureDeviceInput(device: device)
            
            // Set the input device on the capture session.
           if (captureSession?.canAddInput(input) == true){
                captureSession?.addInput(input)
            }
            else {
                print( "Can not had input ")
            }
            
             captureMetaDataOutput = AVCaptureMetadataOutput() //  will be use to read meta data from input
            if (captureSession?.canAddOutput(captureMetaDataOutput) == true ){
                captureSession?.addOutput(captureMetaDataOutput)
                captureMetaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                captureMetaDataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr] // tell that the type of metadata that we want to scan is qr type
            }
            else {
                print("Failed to add metadata output ")
            }
       
            captureSession?.commitConfiguration()
            // layer that
            videoPrewLayer = AVCaptureVideoPreviewLayer(session: captureSession!) // permit to display a video that is being captured
            videoPrewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill // set constraints on layer
            videoPrewLayer?.frame = view.layer.bounds //
            view.layer.addSublayer(videoPrewLayer!) // add this layer on the view layer
    
            // tell the receiver to start running
            captureSession?.startRunning()
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
    }
    
    deinit {
        captureSession?.removeInput(input)
        captureSession?.removeOutput(captureMetaDataOutput)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false

        captureSession?.stopRunning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.isNavigationBarHidden = false
        captureSession?.startRunning()
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    func setUpGesture()
    {
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector (self.dismiss(_:)))
        tap.numberOfTapsRequired = 2
       timeTable.view.addGestureRecognizer(tap)
    }

    

    
    func editAlert(message : String, title: String){
        let edit = UIAlertAction(title: "Edit", style: .default, handler: { action in
            self.editDescription = EditDescriptionController()
            let editTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector (QRCodeController.dismiss(_:)))
            editTap.numberOfTapsRequired = 2
            self.editDescription.view.addGestureRecognizer(editTap)
            self.editDescription.qrCodeInfo = self.qrCodeInfo
            self.present(self.editDescription, animated: true, completion: nil)
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            self.captureSession?.startRunning()
        }
        )
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(edit)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @objc func dismiss(_ sender: Any){
        dismiss(animated: true, completion: nil)
    }
    
    
   
    /*
      this function chek the validity of the form field by field
     */
 
}


// speech reader 

extension QRCodeController {
    func readText(){
        let audioSession =  AVAudioSession.sharedInstance()
        do {  // set the category of the aaudio session
            // tells to the hardware that we want to use the audio hardware components to record and Play sounds
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with: AVAudioSessionCategoryOptions.defaultToSpeaker)
            
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        speechSynthetizer.delegate = self
        let speechUtterance = AVSpeechUtterance(string: speech) // contain the speech and the sttings for the speachSynthetizer
        speechUtterance.voice =  AVSpeechSynthesisVoice(language: "en-GB")
        speechUtterance.rate = 0.45
        speechUtterance.volume = 1.0
        
        speechSynthetizer.speak(speechUtterance) // read the speach
    }
}

// Viper architecture
extension QRCodeController :  QRCodeControllerInput {
    func noDescritpionForRoom() {
        editAlert(message: "No description for the Room do you want to help the dagda community ?", title: "Description")
    }
    
  
    func videoExist(state: Bool) {
        
    }
    
    
    func displayDescription(description: [String : AnyObject]?) { //
        print ("In the display description ")
        timeTable.dictionnary["Day"]?.text = (qrCodeInfo!["Day"]! )
        timeTable.dictionnary["Time"]?.text = (qrCodeInfo!["Time"]! )
        timeTable.dictionnary["Subject"]?.text = (qrCodeInfo!["Subject"]! )
        timeTable.dictionnary["Room"]?.text = (qrCodeInfo!["Room"]! )
        timeTable.descriptionView.text = (description?["description"] as! String)
        generateSpeech()
        timeTable.qrCodeController = self
        timeTable.loadFilURL()
        // before we start to fetch the video on the net
        present(timeTable, animated: true)
    }
    
    
}


// treat the information get in QRCode
extension QRCodeController {
    
    func generateSpeech(){
        speech = "Hi you should follow my instructions. whent it's done tap two times on the screen to quit the view.   Your room position is"
        let data = API.instance.description!
        let instructions = data["description"] as! String
        speech += (" " + instructions)
    }
    
    
    func displayAddDescription() {
        editAlert(message: "No description for this room", title: "Help us")
    }
    
    
    func getArrayInfo(value: String) -> [String:String]? {
        let fields = value.components(separatedBy: "\n")
        var roomData = [String:String]()
        for field in fields{
            let infos = field.components(separatedBy: ": ")
            if (infos[0] != "Day" && infos[0] != "Time" && infos[0] != "Subject" && infos[0] != "Room") {
                return nil
            }
            if infos.count > 0 {
                roomData[infos[0]] = infos[1]
            } else {
                return nil
            }
        }
        
        if  checkValidity(roomData: roomData)  {
            return roomData
        }
        else {
            return nil
        }
    }
    
    
    func checkValidity(roomData: [String:String]) -> Bool{
        guard let _ = roomData["Subject"]  else {return false}
        guard let _ = roomData["Room"]  else {return false}
        guard let _ = roomData["Time"]  else {return false}
        guard let _ = roomData["Day"] else {return false }
        return true
    }
    
    
    func getDay()->String {

        //As part of swift 3 apple has removed NS, making things simpler so
        //new code will be:
        
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        switch day {
        case 0:
            return "Sunday"
        case 1:
            return "Monday"
        case 2:
            return "Tuesday"
        case 3:
            return "Wednesday"
        case 4:
            return "Thurday"
        case 5:
            return "Friday"
        case 6:
            return "Saturday"
  
        default:
            return "unknown"
        }
    }
    
    func checkDate(date: String, day: String) -> Bool{
        let component = date.components(separatedBy: " to ")
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        // split the minute and the hour
        let field = component[1].components(separatedBy: ":")
        // time
        let minuteCourse = field[1]
        let hourCourse = field[0]
       
        //
        if day != getDay() {
            return false
        }
        
        if  hourCourse < String(hour) {
            return false
        }
        else if (hourCourse == String(hour) && minuteCourse < String(minutes)){
            return false
        }
        else if (hourCourse == String(hour) && minuteCourse == String(minutes)){
            return false
        }
        else
        {
            return true
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession?.stopRunning()
            if let metadataObject = metadataObjects.first {
                guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
                guard let stringValue = readableObject.stringValue else { return }
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                
                // start treat metadata
                qrCodeInfo = getArrayInfo(value: stringValue)
                
                if qrCodeInfo != nil {
                    if checkDate(date: qrCodeInfo["Time"]!, day: qrCodeInfo["Day"]!) == false  { // check if the date
                         speech = "Your lesson is not today it was swhedule for "
                         speech = speech + (qrCodeInfo["Day"]! + " at " + qrCodeInfo["Time"]!)
                         speech = speech + (" in room " + qrCodeInfo["Room"]!)
                        readText()
                        self.output.fetchDescriptionIfExist(room: qrCodeInfo["Room"]!)
                    }else {
                        self.output.fetchDescriptionIfExist(room: qrCodeInfo["Room"]!)
                    }
                }
                else {
                    createAlert(title: "Not valid", message: "Invalid QRCode")
                    if !((captureSession?.isRunning)!) {
                        captureSession?.startRunning()
                    }
                }
            }
    }
}
