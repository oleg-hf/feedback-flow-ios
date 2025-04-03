//
//  HistoryView.swift
//  FeedbackFlow
//
//  Created by Oleg Kirsanov on 03.04.25.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    let items: [ResultItem]
    @Binding var isExpanded: Bool
    var onTap: (ResultItem) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
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
            .padding(.bottom, 24)

            if isExpanded {
                ForEach(items.reversed()) { item in
                    Button {
                        onTap(item)
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "doc.text")
                                .foregroundColor(.black.opacity(0.9))

                            Text(item.name)
                                .font(.system(size: 13, weight: .regular))
                                .foregroundColor(.black.opacity(0.9))
                                .lineLimit(1)
                                .truncationMode(.tail)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 14)
                        .background(Color.white)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                    }
                    .padding(.bottom, 8)
                    .transition(.opacity.combined(with: .move(edge: .top)))
                }
            }
        }
    }
}

#Preview {
    VStack(spacing: 24) {
        HistoryView(
            items: [],
            isExpanded: .constant(false),
            onTap: { _ in }
        )

        HistoryView(
            items: [
                ResultItem(question: "Question text text text #1", result: ""),
                ResultItem(question: "Question text text text #2", result: ""),
                ResultItem(question: "Question text text text #3", result: "")
            ],
            isExpanded: .constant(true),
            onTap: { _ in }
        )
    }
}
