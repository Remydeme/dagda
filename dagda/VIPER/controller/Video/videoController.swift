//
//  videoController.swift
//  dagda
//
//  Created by remy DEME on 28/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

protocol VideoControllerInput {
    
}

protocol VideoControllerOutput {
    
}

enum VideoControllerError: Swift.Error {
    case captureSessionAlreadyRunning
    case captureSessionIsMissing
    case inputsAreInvalid
    case invalidOperation
    case noCamerasAvailable
    case unknown
}

class VideoController : UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    // let video parameter
    
    let filename = "video"
    
    
    // interactor
    var interactor : VideoControllerOutput!
    
    // create my session to record video
    let cameraSession = AVCaptureSession()
    var captureDevice : AVCaptureDevice? // check if the device is available
    var captureDeviceInput : AVCaptureDeviceInput?
    var prevLayer : AVCaptureVideoPreviewLayer! //  to add video inside container
    var videoOutput : AVCaptureVideoDataOutput!
    var videoFileOutput : AVCaptureMovieFileOutput?
    
    
    // start button
    
    let startButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "play"), for: .normal)
       return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraSession.sessionPreset = .hd1280x720
    }


   
    
   
}



extension VideoController {
    
    
    func getCaptureDevice() throws {
        let session = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back)
        let cameras = (session.devices.compactMap { $0 })
        if cameras.isEmpty { throw VideoControllerError.noCamerasAvailable }
        
        for camera in cameras {
            
            if camera.position == .back {
                captureDevice = camera
                try camera.lockForConfiguration()
                camera.focusMode = .autoFocus
                camera.unlockForConfiguration()
            }
        }
    }
    
    func configureInput() throws{
        guard let device = captureDevice else  {throw VideoControllerError.noCamerasAvailable}
        do {
            let deviceInput = try (AVCaptureDeviceInput(device: device)) // set the capture device input
            cameraSession.beginConfiguration() // tell that we start the configuration
            if (cameraSession.canAddInput(deviceInput) == true) {
                cameraSession.addInput(deviceInput) // add input to the session here it is the camera
            }
            else {
                return
            }
        }catch let err {
            print(err.localizedDescription)
        }
    }
    
    func configureOutput() throws{
        let dataOutput = AVCaptureVideoDataOutput()
        /* settings
         kCVPixelFormatType_420YpCbCr8BiPlanarFullRange pixel format. This pixel format is composed by two 8-bit components. The first byte represents the luma, while the second byte represents two chroma components (blue and red). This format is also shortly called YCC.
         */
        dataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString) : NSNumber(value: kCVPixelFormatType_420YpCbCr8BiPlanarFullRange as UInt32)] as [String : Any] //compression settings Jpeg
        dataOutput.alwaysDiscardsLateVideoFrames = true // drop tthe video frame if they are late
        
        if (cameraSession.canAddOutput(dataOutput) == true ){
            cameraSession.addOutput(dataOutput)
        }
        else {
            throw VideoControllerError.invalidOperation
        }
        cameraSession.startRunning()
    }
    
    
    
    func displayPreview() throws {
        if !cameraSession.isRunning {
            throw VideoControllerError.captureSessionIsMissing
        }
        
        prevLayer = AVCaptureVideoPreviewLayer(session: cameraSession)
        prevLayer.frame = view.layer.bounds
        prevLayer.connection?.videoOrientation = .portrait
        prevLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(prevLayer)
    }
    
    
    func configure(){
        do {
            try (configureInput())
            try(configureOutput())
            try(displayPreview())
        } catch let err {
            print (err.localizedDescription)
        }
    }
    

    
}

// start and stop recording function recording
extension VideoController {
    
    
    
    @objc func start(name: String){
        if (videoFileOutput == nil || (videoFileOutput?.isRecording)! == false) {
            videoFileOutput = AVCaptureMovieFileOutput()
            if (cameraSession.canAddOutput(videoFileOutput!) == true){
                cameraSession.addOutput(videoFileOutput!)
            } else {
                createAlert(title: "Ok", message: "Can not start record")
                return
            }
            let recordingDelegate : AVCaptureFileOutputRecordingDelegate? = self
            let path = Settings.instance.tempVideoURL().appendingPathComponent(name) // get the temp directory url
            Settings.instance.deleteFile(url: path)
            videoFileOutput?.startRecording(to: path, recordingDelegate: recordingDelegate!)
            startButton.setImage(#imageLiteral(resourceName: "stop"), for: .normal)
        } else {
            startButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            videoFileOutput?.stopRecording()
        }
        
    }
    
 
}

extension VideoController : AVCaptureFileOutputRecordingDelegate {
    
    // function called when the record is over
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        print("record is finished")
        // save file on firebase and display it in the carousel
    }
    
    
}

extension VideoController : VideoControllerInput {
    
}








