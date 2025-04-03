//
//  SubmitButton.swift
//  FeedbackFlow
//
//  Created by Greg Delgado on 03.04.25.
//

import SwiftUI

struct SubmitButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: 56)
        }
        .background(Color.blue)
        .cornerRadius(8)
    }
}

#Preview {
    VStack {
        SubmitButton(title: "Submit", action: {})
        SubmitButton(title: "Ask Another Question", action: {})
    }
    .padding()
}
