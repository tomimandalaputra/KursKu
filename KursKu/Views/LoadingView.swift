//
//  LoadingView.swift
//  KursKu
//
//  Created by Tomi Mandala Putra on 15/05/2025.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.3).ignoresSafeArea()
            ProgressView()
                .tint(.white)
        }
    }
}

#Preview {
    LoadingView()
}
