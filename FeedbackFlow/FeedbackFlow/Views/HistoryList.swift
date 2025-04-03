//
//  HistoryList.swift
//  FeedbackFlow
//
//  Created by Oleg Kirsanov on 03.04.25.
//

import SwiftUI

struct HistoryList: View {
    let items: [ResultItem]
    let onTap: (ResultItem) -> Void

    var body: some View {
        if items.isEmpty {
            Text("No history yet")
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .padding(.top, 4)
                .frame(maxWidth: .infinity, alignment: .center)
        } else {
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
