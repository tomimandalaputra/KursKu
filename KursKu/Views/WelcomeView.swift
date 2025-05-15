//
//  WelcomeView.swift
//  KursKu
//
//  Created by Tomi Mandala Putra on 15/05/2025.
//

import SwiftUI

struct WelcomeView: View {
    @AppStorage("hasSeenWelcomeView") private var hasSeenWelcomeView: Bool = false

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            ZStack {
                Capsule()
                    .foregroundStyle(.blue)
                    .offset(y: UIScreen.main.bounds.height / 1.6)

                VStack {
                    Spacer()

                    Text("Welcome to KursKu")
                        .font(.system(size: 32, weight: .semibold))
                        .foregroundStyle(.blue)

                    Spacer()

                    Text("Access up-to-date exchange rates quickly and easily. Start converting now and stay informed wherever you are.")
                        .foregroundStyle(.white)
                        .font(.system(size: 14))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: 300)
                        .padding(.bottom, 32)

                    Button(action: {
                        hasSeenWelcomeView = true
                    }, label: {
                        Text("Start")
                            .font(.system(size: 16, weight: .semibold))
                            .frame(maxWidth: 300)
                            .frame(height: 48)
                    })
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .frame(width: UIScreen.main.bounds.width * 1.5)
        }
    }
}

#Preview {
    WelcomeView()
}
