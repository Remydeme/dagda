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


class VideoController: UIViewController , VideoControllerInput {
    
    var interactor : VideoControllerOutput!
}

//class VideoController : UIViewController, AVCaptureFileOutputRecordingDelegate {
//
//
//
//
//        let startButton : UIButton = {
//            let button = UIButton(type: .custom)
//            button.setImage(#imageLiteral(resourceName: "play"), for: .normal)
//            button.addTarget(self, action: #selector (startRecording(_:)), for: .touchDown)
//           return button
//        }()
//
//    let captureSession = AVCaptureSession()
//
//    let movieOutput = AVCaptureMovieFileOutput()
//
//    var previewLayer: AVCaptureVideoPreviewLayer!
//
//    var activeInput: AVCaptureDeviceInput!
//
//    var videoFileOutput : AVCaptureMovieFileOutput?
//
//    var interactor : VideoControllerOutput!
//
//    var filename = ""
//
//    var outputURL: URL!
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        if setupSession() {
//            setupPreview()
//            startSession()
//        }
//        setView()
//        VideoConfigurer.instance.configure(controller: self)
//        startButton.addTarget(self, action: #selector (startRecording(_:)), for: .touchDown)
//    }
//
//    func setupPreview() {
//        // Configure previewLayer
//        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//        previewLayer.frame = view.frame
//        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
//        view.layer.addSublayer(previewLayer)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: videoNotification), object: nil)
//    }
//    //MARK:- Setup Camera
//
//    func setupSession() -> Bool {
//
//        captureSession.sessionPreset = AVCaptureSession.Preset.high
//        // Setup Camera
//        let camera = AVCaptureDevice.default(for: AVMediaType.video)
//
//        do {
//            let input = try AVCaptureDeviceInput(device: camera!)
//            if captureSession.canAddInput(input) {
//                captureSession.addInput(input)
//                activeInput = input
//            }
//        } catch {
//            print("Error setting device video input: \(error)")
//            return false
//        }
//
//        // Setup Microphone
//        let microphone = AVCaptureDevice.default(for: AVMediaType.audio)
//
//        do {
//            let micInput = try AVCaptureDeviceInput(device: microphone!)
//            if captureSession.canAddInput(micInput) {
//                captureSession.addInput(micInput)
//            }
//        } catch {
//            print("Error setting device audio input: \(error)")
//            return false
//        }
//
//
//        // Movie output
//        if captureSession.canAddOutput(movieOutput) {
//            captureSession.addOutput(movieOutput)
//        }
//
//        return true
//    }
//
//
//
//    func startSession() {
//
//
//        if !captureSession.isRunning {
//            videoQueue().async {
//                self.captureSession.startRunning()
//            }
//        }
//    }
//
//    func stopSession() {
//        if captureSession.isRunning {
//            videoQueue().async {
//                self.captureSession.stopRunning()
//            }
//        }
//    }
//
//    func videoQueue() -> DispatchQueue {
//        return DispatchQueue.main
//    }
//
//
//    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
//    }
//
//
//}
//
//extension VideoController{
//
//
//    func currentVideoOrientation() -> AVCaptureVideoOrientation {
//        var orientation: AVCaptureVideoOrientation
//
//        switch UIDevice.current.orientation {
//        case .portrait:
//            orientation = AVCaptureVideoOrientation.portrait
//        case .landscapeRight:
//            orientation = AVCaptureVideoOrientation.landscapeLeft
//        case .portraitUpsideDown:
//            orientation = AVCaptureVideoOrientation.portraitUpsideDown
//        default:
//            orientation = AVCaptureVideoOrientation.landscapeRight
//        }
//
//        return orientation
//    }
//
//
//    func tempURL() -> URL? {
//       return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(filename).appendingPathExtension("mp4")
//        }
//
//
//
//
//    @objc func startRecording(_ sender: Any) {
//
//        if movieOutput.isRecording == false {
//
//            let connection = movieOutput.connection(with: AVMediaType.video)
//            if (connection?.isVideoOrientationSupported)! {
//                connection?.videoOrientation = currentVideoOrientation()
//            }
//
//            if (connection?.isVideoStabilizationSupported)! {
//                connection?.preferredVideoStabilizationMode = AVCaptureVideoStabilizationMode.auto
//            }
//
//            let device = activeInput.device
//            if (device.isSmoothAutoFocusSupported) {
//                do {
//                    try device.lockForConfiguration()
//                    device.isSmoothAutoFocusEnabled = false
//                    device.unlockForConfiguration()
//                } catch {
//                    print("Error setting configuration: \(error)")
//                }
//
//            }
//
//            startButton.setImage(#imageLiteral(resourceName: "stop"), for: .normal)
//            outputURL = tempURL()
//            movieOutput.startRecording(to: outputURL, recordingDelegate: self)
//
//        }
//        else {
//            stopRecording()
//            startButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
//        }
//
//    }
//
//    @objc func stopRecording() {
//
//        if movieOutput.isRecording == true {
//            movieOutput.stopRecording()
//        }
//    }
//
//    func capture(_ captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAt fileURL: URL!, fromConnections connections: [Any]!) {
//
//    }
//
//    func capture(_ captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAt outputFileURL: URL!, fromConnections connections: [Any]!, error: Error!) {
//        if (error != nil) {
//            print("Error recording movie: \(error!.localizedDescription)")
//        } else {
//
//            _ = outputURL as URL
//
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: videoNotification), object: nil)
//            navigationController?.popViewController(animated: true)
//        }
//        outputURL = nil
//    }
//
//    func setView(){
//                startButton.translatesAutoresizingMaskIntoConstraints = false
//
//               view.addSubview(startButton)
//
//                startButton.heightAnchor.constraint(equalToConstant: 90).isActive = true
//                startButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
//
//                startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//                startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
//
//            }
//}
//
//
//
////class VideoController : UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
////
////    // let video parameter
////
////    var filename = ""
////
////    // interactor
////    var interactor : VideoControllerOutput!
////
////    // create my session to record video
////    let cameraSession = AVCaptureSession()
////    var captureDevice : AVCaptureDevice? // check if the device is available
////    var captureDeviceInput : AVCaptureDeviceInput?
////    var prevLayer : AVCaptureVideoPreviewLayer! //  to add video inside container
////    var videoOutput : AVCaptureVideoDataOutput!
////    var deviceInput : AVCaptureInput!
////    var videoFileOutput : AVCaptureMovieFileOutput?
////
////    // start button
////
////    let startButton : UIButton = {
////        let button = UIButton(type: .custom)
////        button.setImage(#imageLiteral(resourceName: "play"), for: .normal)
////        button.addTarget(self, action: #selector (start(_:)), for: .touchDown)
////       return button
////    }()
////
////
////    override func viewDidLoad() {
////        super.viewDidLoad()
////        view.backgroundColor = .white
////        tabBarController?.tabBar.isHidden = true
////        navigationController?.isNavigationBarHidden = false
////        cameraSession.sessionPreset = .hd1280x720
////        configure()
////        setView()
////    }
////
////
////    override func viewWillDisappear(_ animated: Bool) {
////        super.viewWillDisappear(animated)
////        cameraSession.stopRunning()
////        cameraSession.removeInput(deviceInput)
////    }
////
////
////}
////
////
////
////extension VideoController {
////
////
////    func getCaptureDevice() throws {
////        let session = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back)
////        let cameras = (session.devices.compactMap { $0 })
////        if cameras.isEmpty { throw VideoControllerError.noCamerasAvailable }
////
////        for camera in cameras {
////
////            if camera.position == .back {
////                captureDevice = camera
////                try camera.lockForConfiguration()
////                camera.focusMode = .autoFocus
////                camera.unlockForConfiguration()
////            }
////        }
////    }
////
////    func configureInput() throws{
////        guard let device = captureDevice else
////        {throw VideoControllerError.noCamerasAvailable}
////        do {
////             deviceInput = try (AVCaptureDeviceInput(device: device)) // set the capture device input
////            if (cameraSession.canAddInput(deviceInput) == true) {
////                cameraSession.addInput(deviceInput) // add input to the session here it is the camera
////            }
////            else {
////                return
////            }
////        }catch let err {
////            print(err.localizedDescription)
////        }
////    }
////
////    func configureOutput() throws{
////        let dataOutput = AVCaptureVideoDataOutput()
////        /* settings
////         kCVPixelFormatType_420YpCbCr8BiPlanarFullRange pixel format. This pixel format is composed by two 8-bit components. The first byte represents the luma, while the second byte represents two chroma components (blue and red). This format is also shortly called YCC.
////         */
////        dataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString) : NSNumber(value: kCVPixelFormatType_420YpCbCr8BiPlanarFullRange as UInt32)] as [String : Any] //compression settings Jpeg
////        dataOutput.alwaysDiscardsLateVideoFrames = true // drop tthe video frame if they are late
////
////        if (cameraSession.canAddOutput(dataOutput) == true ){
////            cameraSession.addOutput(dataOutput)
////        }
////        else {
////            throw VideoControllerError.invalidOperation
////        }
////        cameraSession.startRunning()
////    }
////
////
////
////    func displayPreview() throws {
////        if !cameraSession.isRunning {
////            throw VideoControllerError.captureSessionIsMissing
////        }
////
////        prevLayer = AVCaptureVideoPreviewLayer(session: cameraSession)
////        prevLayer.frame = view.layer.bounds
////        prevLayer.connection?.videoOrientation = .portrait
////        prevLayer.videoGravity = .resizeAspectFill
////        view.layer.addSublayer(prevLayer)
////    }
////
////
////    func configure(){
////        do {
////            try(getCaptureDevice())
////            try (configureInput())
////            try(configureOutput())
////            try(displayPreview())
////        } catch let err {
////            print (err.localizedDescription)
////        }
////    }
////
////
////
////}
////
////// start and stop recording function recording
////extension VideoController {
////
////
////
////    @objc func start(_ sender: Any){
////        if (videoFileOutput == nil || (videoFileOutput?.isRecording) == true) {
////            videoFileOutput = AVCaptureMovieFileOutput()
////            if (cameraSession.canAddOutput(videoFileOutput!) == true){
////                cameraSession.addOutput(videoFileOutput!)
////            } else {
////                createAlert(title: "Ok", message: "Can not start record")
////                return
////            }
////            let recordingDelegate : AVCaptureFileOutputRecordingDelegate? = self
////            let path = Settings.instance.tempVideoURL().appendingPathComponent(self.filename) // get the temp directory url
////            Settings.instance.deleteFile(url: path)
////            videoFileOutput?.startRecording(to: path, recordingDelegate: recordingDelegate!)
////            startButton.setImage(#imageLiteral(resourceName: "stop"), for: .normal)
////        } else {
////            startButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
////            videoFileOutput?.stopRecording()
////            cameraSession.stopRunning()
////            cameraSession.removeInput(deviceInput)
////        }
////
////    }
////
////
////}
////
////extension VideoController : AVCaptureFileOutputRecordingDelegate {
////
////    // function called when the record is over
////    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
////        print ("error remy : " + (error?.localizedDescription)!)
////        NotificationCenter.default.post(name: NSNotification.Name(rawValue: videoNotification), object: nil)
////        navigationController?.popViewController(animated: true)
////        // save file on firebase and display it in the carousel
////    }
////
////    func fileOutput(_ output: AVCaptureFileOutput, didStartRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {
////        print("start")
////    }
////
////}
////
////
////// set view button
////extension VideoController{
////    func setView(){
////        startButton.translatesAutoresizingMaskIntoConstraints = false
////        view.addSubview(startButton)
////
////        startButton.heightAnchor.constraint(equalToConstant: 90).isActive = true
////        startButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
////
////        startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
////        startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
////
////    }
////}
////
////extension VideoController : VideoControllerInput {
////
////}
////
////
////
////
////
////
////
////
