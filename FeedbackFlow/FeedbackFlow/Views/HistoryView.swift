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
    let onTap: (ResultItem) -> Void
    let onClear: () -> Void

    @State private var showConfirmation = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HistoryViewHeader(
                isExpanded: isExpanded,
                hasItems: !items.isEmpty,
                onToggle: { isExpanded.toggle() },
                onClear: onClear,
                showConfirmation: $showConfirmation
            )

            if isExpanded {
                HistoryList(items: items, onTap: onTap)
            }
        }
        .alert("Clear History", isPresented: $showConfirmation) {
            Button(
                "Yes, clear",
                role: .destructive, action: onClear
            )
            Button(
                "Cancel",
                role: .cancel
            ) {}
        } message: {
            Text("Are you sure you want to clear your history?")
        }
    }
}

#Preview {
    VStack(spacing: 24) {
        HistoryView(
            items: [],
            isExpanded: .constant(false),
            onTap: { _ in },
            onClear: {}
        )

        HistoryView(
            items: [
                ResultItem(question: "Question text text text #1", result: ""),
                ResultItem(question: "Question text text text #2", result: ""),
                ResultItem(question: "Question text text text #3", result: "")
            ],
            isExpanded: .constant(true),
            onTap: { _ in },
            onClear: {}
        )
    }
}
