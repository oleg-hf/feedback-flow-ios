//
//  InitialView.swift
//  FeedbackFlow
//
//  Created by Oleg Kirsanov on 03.04.25.
//

import SwiftUI
import SwiftData

struct InitialView: View {
    @ObservedObject var viewModel: ContentViewModel
    let items: [ResultItem]
    @Binding var isExpanded: Bool

    var body: some View {
        VStack(spacing: 24) {
            Text("Type your question here")
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(Color.gray.opacity(0.9))

            TextEditor(text: $viewModel.questionText)
                .padding(8)
                .frame(height: 180)
                .font(.system(size: 16, weight: .regular))
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.7), lineWidth: 1.5)
                )
                .cornerRadius(12)

            SubmitButton(title: "Submit", action: viewModel.didTapSubmitButton)
                .padding(.vertical, 20)

            if !viewModel.errorText.isEmpty {
                Text(viewModel.errorText)
                    .foregroundColor(.red)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }

            if !items.isEmpty {
                HistoryView(
                    items: items,
                    isExpanded: $isExpanded,
                    onTap: { item in
                        viewModel.showResult(from: item)
                    }
                )
            }

            Spacer()
        }
    }
}
