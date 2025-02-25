//
//  ContentView.swift
//  LiftAssistant
//
//  Created by Sameer Sinha on 2/25/25.
//

import SwiftUI


struct ContentView: View {
    @StateObject private var cameraViewModel = CameraViewModel()

    var body: some View {
        ZStack {
            CameraView(viewModel: cameraViewModel)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Text("Pose Detection")
                    .font(.title)
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

#Preview {
    ContentView()
}
