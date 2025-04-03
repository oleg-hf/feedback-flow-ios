//
//  HistoryViewHeader.swift
//  FeedbackFlow
//
//  Created by Oleg Kirsanov on 03.04.25.
//

import SwiftUI

struct HistoryViewHeader: View {
    let isExpanded: Bool
    let hasItems: Bool
    let onToggle: () -> Void
    let onClear: () -> Void

    @Binding var showConfirmation: Bool

    var body: some View {
        HStack {
            Button(action: {
                withAnimation { onToggle() }
            }) {
                HStack(spacing: 8) {
                    Image(systemName: "clock.arrow.circlepath")
                        .foregroundColor(.black.opacity(0.9))
                        .imageScale(.medium)

                    Text("View History")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black.opacity(0.8))

                    Spacer()

                    Image(systemName: "chevron.down")
                        .foregroundColor(.black.opacity(0.8))
                        .imageScale(.medium)
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                        .animation(.easeInOut(duration: 0.25), value: isExpanded)
                }
            }

            if hasItems {
                Button {
                    showConfirmation = true
                } label: {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                        .font(.system(size: 12))
                        .padding(10)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                }
                .padding(.leading, 8)
            }
        }
        .padding(.bottom, 24)
    }
}
