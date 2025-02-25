//
//  CameraView.swift
//  LiftAssistant
//
//  Created by Sameer Sinha on 2/25/25.
//

import SwiftUI
import AVFoundation

struct CameraView: UIViewControllerRepresentable {
    @ObservedObject var viewModel: CameraViewModel

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        if let previewLayer = viewModel.previewLayer {
            previewLayer.frame = UIScreen.main.bounds
            viewController.view.layer.addSublayer(previewLayer)
        }
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
