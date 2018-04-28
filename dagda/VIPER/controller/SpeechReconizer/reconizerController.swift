//
//  reconizerController.swift
//  dagda
//
//  Created by remy DEME on 17/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation
import AVFoundation
import Speech
import UIKit


class SpeechReconizerController : UIViewController, SFSpeechRecognizerDelegate{
    
    // settings
    let bus = 0
    let bufferSize = 1024
    // variables
    
    let audioEngine = AVAudioEngine() // process the audio stream
    let speechReconizer : SFSpeechRecognizer? = SFSpeechRecognizer() // do the speach reconigtion
    var request = SFSpeechAudioBufferRecognitionRequest() // buffer that will keep the record
    let startButton = UIButton(type: .custom)
    var node : AVAudioInputNode!
    var recognitionTask : SFSpeechRecognitionTask! // enable to stop or play the recording
    
    
    var outputView = textViewWith()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestAuthorization()
        startButton.setImage(#imageLiteral(resourceName: "mic"), for: .normal)
    }
    

    func microphonePermission(){
        switch AVAudioSession.sharedInstance().recordPermission() {
        case AVAudioSessionRecordPermission.granted:
            print("Permission granted")
        case AVAudioSessionRecordPermission.denied:
            print("Pemission denied")
        case AVAudioSessionRecordPermission.undetermined:
            print("Request permission here")
            AVAudioSession.sharedInstance().requestRecordPermission({ (granted) in
                // Handle granted
            })
        }
    }
    
    func requestAuthorization(){
        SFSpeechRecognizer.requestAuthorization({ auhtStatus in
            OperationQueue.main.addOperation {
                switch auhtStatus
                {
                case .authorized:
                    self.startButton.isEnabled = true
                    break
                case .notDetermined:
                    self.startButton.isEnabled = false
                    self.createAlert(title: "Permission", message:"Permission not determined")
                case .denied:
                    self.startButton.isEnabled = false
                    self.createAlert(title: "Permission", message:"Permission refused")
                case .restricted:
                    self.startButton.isEnabled = false
                    self.createAlert(title: "Permission", message:"Permission restricted")
                }
            }
        })
    }
    
    
    
    func setAudioSessionSettings(){
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
    }
    
    
    func microphoneTaped(_ sender: Any){
        
        if audioEngine.isRunning {
           audioEngine.stop()
           request.endAudio()
           startButton.setImage(#imageLiteral(resourceName: "mic"), for: .normal)
           node.removeTap(onBus: bus)
        }
        else {
           recordAndReconize()
            startButton.setImage(#imageLiteral(resourceName: "stop"), for: .normal)
        }
    }
    
    func recordAndReconize(){
     
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil 
        }
        // set audio cession settings
         setAudioSessionSettings()
         microphonePermission()
         // set delegate
        speechReconizer?.delegate = self
       
        /*
         node are use to process bit of audio
         those information came from the buses
         */
      
        /*
          install a tap on the audio
          set the request buffer and bus
         */
       
        guard let recognizer = SFSpeechRecognizer() else {
            createAlert(title: "Recognizer", message: "Not supported for the local")
            return
        }
        
        if !recognizer.isAvailable {
            // not available
            createAlert(title: "Recognizer", message: "Not available now")
            return
        }
      
   
        node = audioEngine.inputNode
        
        self.request = SFSpeechAudioBufferRecognitionRequest()
        // start the task
        
        // clean the bus
        recognitionTask = speechReconizer?.recognitionTask(with: request, resultHandler: { result, error in
            var isFinal = false
            if let res = result {
                
                let description = res.bestTranscription.formattedString
                self.outputView.text! = description
                
                isFinal = (result?.isFinal)!
                print (isFinal)
            }
            else if error != nil { // if the task is over or error occur
            }
            
            if isFinal {
                print("In the stop isfinal ")
                self.audioEngine.stop()
                self.recognitionTask = nil
                self.startButton.isEnabled = true
                self.node.removeTap(onBus: self.bus)
            }
        })
        
        let recordingFormat = node.outputFormat(forBus: bus)
        

        node.installTap(onBus: bus, bufferSize: AVAudioFrameCount(bufferSize), format: recordingFormat, block: {buffer,  _ in
            self.request.append(buffer)
        })
        
        
        // prepare and start the recording using the audio engine
        
        audioEngine.prepare() // prepare the audio engine to prepare
        
        do {
            try (audioEngine.start())
        }catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    

    
    
}





