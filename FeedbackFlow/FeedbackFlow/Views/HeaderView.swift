//
//  HeaderView.swift
//  FeedbackFlow
//
//  Created by Greg Delgado on 03.04.25.
//

import SwiftUI

struct HeaderView: View {
    var title: String = "FeedbackFlow"
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                .edgesIgnoringSafeArea(.top)
            
            Text(title)
                .font(.system(size: 20, weight: .bold))
                .padding(.top, 16)
                .padding(.bottom, 16)
        }
        .frame(height: 40)
    }
}

#Preview {
    HeaderView()
}
