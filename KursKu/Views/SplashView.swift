//
//  SplashView.swift
//  KursKu
//
//  Created by Tomi Mandala Putra on 15/05/2025.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()

            VStack {
                Spacer()
                Text("KursKu")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundStyle(.white)
                Spacer()
                Text("by Tukucode - 2025")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    SplashView()
}
