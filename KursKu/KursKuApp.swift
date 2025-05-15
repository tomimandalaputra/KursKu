//
//  KursKuApp.swift
//  KursKu
//
//  Created by Tomi Mandala Putra on 15/05/2025.
//

import SwiftUI

@main
struct KursKuApp: App {
    @AppStorage("hasSeenWelcomeView") private var hasSeenWelcomeView: Bool = false
    @State private var showSplashView = true

    var body: some Scene {
        WindowGroup {
            Group {
                if showSplashView {
                    SplashView().transition(.opacity)
                } else {
                    if hasSeenWelcomeView {
                        HomeView()
                            .transition(.move(edge: .trailing))
                    } else {
                        WelcomeView()
                            .transition(.move(edge: .bottom))
                    }
                }
            }
            .animation(.easeInOut(duration: 0.5), value: showSplashView)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        showSplashView = false
                    }
                }
            }
        }
    }
}
