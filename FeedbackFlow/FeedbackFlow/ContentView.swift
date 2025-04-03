//
//  ContentView.swift
//  FeedbackFlow
//
//  Created by Oleg Kirsanov on 02.04.25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject var viewModel: ContentViewModel
    @Query var items: [ResultItem]
    @State private var isExpanded = false

    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 16) {
                    HeaderView()

                    ScrollView {
                        InitialView(
                            viewModel: viewModel,
                            items: items,
                            isExpanded: $isExpanded
                        )
                        .padding(.horizontal, 16)
                    }
                    .padding(.top, 32)
                }
                .background(Color.gray.opacity(0.1))

                if viewModel.isLoading {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()

                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5)
                }
            }
            .navigationDestination(isPresented: $viewModel.shouldShowResults) {
                ResultsView(
                    question: viewModel.questionText,
                    response: viewModel.responseText,
                    onAskAnotherQuestion: {
                        viewModel.resetForm()
                    }
                )
            }
            .onChange(of: viewModel.shouldShowResults) { _, newValue in
                if !newValue {
                    isExpanded = false
                    viewModel.resetForm()
                }
            }
        }
    }
}
