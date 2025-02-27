//
//  CameraViewModel.swift
//  LiftAssistant
//
//  Created by Sameer Sinha on 2/25/25.
//

import AVFoundation
import SwiftUI

class CameraViewModel: NSObject, ObservableObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    private let captureSession = AVCaptureSession()
    @Published var previewLayer: AVCaptureVideoPreviewLayer?

    override init() {
        super.init()
        setupCamera()
    }

    private func setupCamera() {
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else {
            print("No camera found")
            return
        }

        do {
            let input = try AVCaptureDeviceInput(device: device)
            if captureSession.canAddInput(input) { captureSession.addInput(input) }

            let output = AVCaptureVideoDataOutput()
            output.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
            if captureSession.canAddOutput(output) { captureSession.addOutput(output) }

            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer?.videoGravity = .resizeAspectFill
            captureSession.startRunning()
        } catch {
            print("Error setting up camera: \(error)")
        }
    }
    
    // RE CHECK THIS
    func checkSquatDepth(leftHip: CGPoint, leftKnee: CGPoint, leftAnkle: CGPoint) {
        let kneeToHip = leftHip.y - leftKnee.y
        let ankleToKnee = leftKnee.y - leftAnkle.y

        if kneeToHip < ankleToKnee {
            print("Squat too shallow! Lower your hips more.")
        }
    }


    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }

        if let keypoints = moveNetModel.runPoseDetection(pixelBuffer: pixelBuffer) {
            print("Keypoints: \(keypoints)")
            // TODO: Analyze form based on keypoints
        }
    }
}
