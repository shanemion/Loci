//
//  ImmersivePanel.swift
//  Loci
//
//  Created by Shane Mion on 6/1/24.
//
import Foundation
import SwiftUI
import RealityKit

struct ImmersiveSpacePanel: View {
    @Binding var showImmersiveSpace: Bool
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    var body: some View {
        VStack {
            Text("Immersive Space Panel")
                .font(.largeTitle)
                .padding(.top, 50)

            Button(showImmersiveSpace ? "Close Immersive Space" : "Open Immersive Space") {
                Task {
                    if showImmersiveSpace {
                        await dismissImmersiveSpace()
                        showImmersiveSpace = false
                    } else {
                        switch await openImmersiveSpace(id: "ImmersiveSpace") {
                        case .opened:
                            showImmersiveSpace = true
                        case .error, .userCancelled:
                            showImmersiveSpace = false
                        @unknown default:
                            showImmersiveSpace = false
                        }
                    }
                }
            }
            .buttonStyle(.bordered)
            .padding()
        }
        .padding(70)
    }
}