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
        VStack(spacing: 16) {
            header

            ScrollView {
                initialView
            }
            .padding(.horizontal, 16)
            .padding(.top, 32)
        }
        .background(Color.gray.opacity(0.1))
    }
}

private extension ContentView {
    @ViewBuilder
    var header: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                .edgesIgnoringSafeArea(.top)

            Text("FeedbackFlow")
                .font(.system(size: 20, weight: .bold))
                .padding(.top, 16)
                .padding(.bottom, 16)
        }
        .frame(height: 40)
    }

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

            Button("Submit") {
                viewModel.didTapSubmitButton()
            }
            .frame(maxWidth: .infinity, minHeight: 56)
            .background(Color.blue)
            .foregroundColor(.white)
            .font(.system(size: 16, weight: .semibold))
            .cornerRadius(8)

            if viewModel.isLoading {
                ProgressView()
                    .padding(.top, 16)
            }

            if !viewModel.responseText.isEmpty {
                Text(viewModel.responseText)
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
