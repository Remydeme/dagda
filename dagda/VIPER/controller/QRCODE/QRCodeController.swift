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



class QRCodeController : UIViewController, AVCaptureMetadataOutputObjectsDelegate,  AVSpeechSynthesizerDelegate  {
    
    var captureSession : AVCaptureSession? // to perform a real time capture cession
    var videoPrewLayer : AVCaptureVideoPreviewLayer?
    var qrCodeFrameView : UIView!
    var timeTable : TimeTableController!
    var editDescription: EditDescriptionController!
    var topController : QRCodeHomeController!
    var qrCodeInfo : [String:String]!
    
    var speech = ""
    // speech synthetizer
    
    let speechSynthetizer = AVSpeechSynthesizer()
    
    
    
    override func viewDidLoad() {
        setUp()
        setCamera()
    }
    
    func setUp(){
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = true
        timeTable = TimeTableController()
        captureSession = AVCaptureSession()
        setUpGesture()
    }
    
 
    
    func setCamera(){
        //let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera], mediaType: AVMediaType.video, position: .back)
        guard let  device = AVCaptureDevice.default(for: .video) else {
            print ("Error capture device ")
            return
        }
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: device)
            
            // Set the input device on the capture session.
            if (captureSession?.canAddInput(input))!{
                captureSession?.addInput(input)
            }
            else {
                print( "Can not had input ")
            }
            
            let captureMetaDataOutput = AVCaptureMetadataOutput() //  will be use to read meta data from input
            if (captureSession?.canAddOutput(captureMetaDataOutput))! {
                captureSession?.addOutput(captureMetaDataOutput)
                captureMetaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                captureMetaDataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr] // tell that the type of metadata that we want to scan is qr type
            }
            else {
                print("Failed to add metadata output ")
            }
       
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
    
   

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        captureSession?.stopRunning()
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        captureSession?.startRunning()
        navigationController?.isNavigationBarHidden = false
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        captureSession?.startRunning()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        readText()
    }
    
    func setUpGesture()
    {
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector (QRCodeController.dismiss(_:)))
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
            self.captureSession?.stopRunning()
            self.present(self.editDescription, animated: true, completion: nil)
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { action in })
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(edit)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
    


    
    @objc func dismiss(_ sender: Any){
        dismiss(animated: true, completion: nil)
    }
    
    
    func getArrayInfo(value: String) -> [String:String]? {
        let fields = value.components(separatedBy: "\n")
        var roomData = [String:String]()
        for field in fields{
            let infos = field.components(separatedBy: ": ")
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
    
    func checkValidity(roomData: [String:String]) -> Bool{ // can check if the hours is good or not ...
        guard let _ = roomData["Subject"]  else {return false}
        guard let _ = roomData["Room"]  else {return false}
        guard let _ = roomData["Time"]  else {return false}
        guard let _ = roomData["Day"] else {return false }
        return true
    }
    
    func generateSpeech(){
        speech = "Hi you should follow my instructions. whent it's done tap two times on the screen to quit."
        let data = API.instance.data!
        let instructions = data["description"] as! String 
        speech += (" " + instructions)
    }
    
    func readText(){
        let audioSession =  AVAudioSession.sharedInstance()
        do {
            
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with: AVAudioSessionCategoryOptions.defaultToSpeaker)
            
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        speechSynthetizer.delegate = self
        let speechUtterance = AVSpeechUtterance(string: speech)
        speechUtterance.voice =  AVSpeechSynthesisVoice(language: "en-GB")
       
        speechUtterance.volume = 1.0
        
        speechSynthetizer.speak(speechUtterance)
    }
    

    
 
 
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
    
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            // start treat metadata
            qrCodeInfo = getArrayInfo(value: stringValue)
            if qrCodeInfo != nil {
                API.instance.roomDescriptionExists(room: (qrCodeInfo?["Room"])!)
                if API.instance.exist {
                        timeTable.dictionnary["Day"]?.text = qrCodeInfo?["Day"]
                        timeTable.dictionnary["Time"]?.text = qrCodeInfo?["Time"]
                        timeTable.dictionnary["Subject"]?.text = qrCodeInfo?["Subject"]
                        timeTable.dictionnary["Room"]?.text = qrCodeInfo?["Room"]
                        timeTable.qrCodeController = self 
                        self.present(timeTable, animated: true, completion: nil)
                    }
                    else {
                        editAlert(message: "No description for this room", title: "Help us")
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
