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


class SpeechReconizerController : UIViewController{
    
    let audioEngine = AVAudioEngine() // process the audio stream
    let speechReconizer : SFSpeechRecognizer? = SFSpeechRecognizer() // do the speach reconigtion
    let request = SFSpeechAudioBufferRecognitionRequest() // buffer that will keep the record
    let startButton = UIButton(type: .custom)
    var recognitionTask : SFSpeechRecognitionTask! // enable to stop or play the recording
    
    
    var outputView = textViewWith()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestAuthorization()
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
    
    @objc func reccordAndReconize(){
        /*
          node are use to process bit of audio
          those information came from the buses
         */
        let bus = 0
        let bufferSize = 1024
        let node = audioEngine.inputNode // get the singleton input node of audio engine
        let recordingFormat = node.outputFormat(forBus: bus)
        /*
          install a tap on the audio
          set the request buffer and bus
         */
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
        
        guard let recognizer = SFSpeechRecognizer() else {
            createAlert(title: "Recognizer", message: "Not supported for the local")
            return
        }
        
        if !recognizer.isAvailable {
            // not available
            createAlert(title: "Recognizer", message: "Not available now")
            return
        }
        
        // start the task
        
        recognitionTask = speechReconizer?.recognitionTask(with: request, resultHandler: { result, error in
            
            if let res = result {
                
                let description = res.bestTranscription.formattedString
                self.outputView.text = description
            }
            else if let err = error  {
                self.createAlert(title: "Recognition", message: err.localizedDescription)
            }
        })
    }
    
}





