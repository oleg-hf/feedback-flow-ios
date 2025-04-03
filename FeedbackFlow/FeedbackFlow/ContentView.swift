//
//  ContentView.swift
//  FeedbackFlow
//
//  Created by Oleg Kirsanov on 02.04.25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                initialView
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
            }
            .background(Color.gray.opacity(0.1))
            .navigationTitle("FeedbackFlow")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $viewModel.shouldShowResults) {
                ResultsView(
                    question: viewModel.questionText,
                    response: viewModel.responseText,
                    onAskAnotherQuestion: {
                        viewModel.resetForm()
                    }
                )
            }
        }
    }
}

private extension ContentView {

    @ViewBuilder
    var initialView: some View {
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
            if viewModel.isLoading {
                ProgressView()
                    .padding(.top, 16)
            }

            if !viewModel.errorText.isEmpty {
                Text(viewModel.errorText)
                    .foregroundColor(.red)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }

            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
