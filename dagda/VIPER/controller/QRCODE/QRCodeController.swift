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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
       timeTable.view.addGestureRecognizer(tap)
    }
    
    func alert(message : String, title: String){
        let action = UIAlertAction(title: "Alert", style: .default, handler: nil)
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    


    
    @objc func dismiss(_ sender: Any){
        dismiss(animated: true, completion: nil)
    }
    
    
    func getArrayInfo(value: String) -> [String:String] {
        let fields = value.components(separatedBy: "\n")
        var infoDico = [String:String]()
        for field in fields{
            let infos = field.components(separatedBy: ": ")
            infoDico[infos[0]] = infos[1]
        }
        return infoDico
    }
    
    func checkValidity(roomData: [String:String]) -> Bool{ // can check if the hours is good or not ...
        guard let _ = roomData["Subject"]  else {return false}
        guard let _ = roomData["Room"]  else {return false}
        guard let _ = roomData["Time"]  else {return false}
        return true
    }
    
    func generateSpeech() -> String{
        var speech = ""
        speech += "You have "
        speech += (timeTable.dictionnary["Subject"]?.text!)!
        speech += " class in room "
        speech += (timeTable.dictionnary["Room"]?.text!)!
        speech += " at " + (timeTable.dictionnary["Time"]?.text!)!
        return speech
    }
    
    func readText(){
        let audioSession =  AVAudioSession.sharedInstance()
        do {
            
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with: AVAudioSessionCategoryOptions.defaultToSpeaker)
            
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        let speech = generateSpeech()
        speechSynthetizer.delegate = self
        let speechUtterance = AVSpeechUtterance(string: speech)
        speechUtterance.voice =  AVSpeechSynthesisVoice(language: "en-GB")
       
        speechUtterance.volume = 1.0
        
        speechSynthetizer.speak(speechUtterance)
    }
    

    
    func setTimeTableLabel(controller: TimeTableController, info: [String:String], type: QRCODETYPE){
        switch type {
        case .known:
            controller.dictionnary["Day"]?.text = info["Day"]
            controller.dictionnary["Time"]?.text = info["Time"]
            controller.dictionnary["Subject"]?.text = info["Subject"]
            controller.dictionnary["Room"]?.text = info["Room"]
            self.present(timeTable, animated: true, completion: nil)
        case .unknown: // implement un function qui regarde si une clef existe
            editDescription = EditDescriptionController()
            self.present(editDescription, animated: true, completion: nil)
            break
        case .notValid:
            
            break
        }
        
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
    
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            let qrCodeInfo = getArrayInfo(value: stringValue)
            if checkValidity(roomData: qrCodeInfo){
                setTimeTableLabel(controller: timeTable, info: qrCodeInfo, type: .known)
            }
            else {
                setTimeTableLabel(controller: timeTable, info: qrCodeInfo, type: .notValid)
            }
        }
    
    }
    
}
