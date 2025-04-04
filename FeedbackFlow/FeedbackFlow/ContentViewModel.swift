//
//  ContentViewModel.swift
//  FeedbackFlow
//
//  Created by Oleg Kirsanov on 02.04.25.
//

import SwiftUI
import SwiftData

class ContentViewModel: ObservableObject {
    @Published var questionText = ""
    @Published var responseText = ""
    @Published var isLoading = false
    @Published var shouldShowResults = false
    @Published var shouldShowError = false

    private(set) var errorText = ""

    private let networkService = NetworkService()
    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func didTapSubmitButton() {
        guard !questionText.isEmpty else {
            return
        }

        isLoading = true

        Task {
            do {
                let result = try await networkService.sendPrompt(questionText)

                await MainActor.run {
                    self.responseText = result
                    self.isLoading = false
                    self.shouldShowResults = true
                    let item = ResultItem(question: questionText, result: result)
                    self.modelContext.insert(item)
                }
            } catch {
                await MainActor.run {
                    self.errorText = "Error: \(error.localizedDescription)"
                    self.isLoading = false
                    self.shouldShowResults = false
                    self.shouldShowError = true
                }
            }
        }
    }

    func showResult(from item: ResultItem) {
        questionText = item.question
        responseText = item.result
        shouldShowResults = true
    }

    func resetForm() {
        questionText = ""
        responseText = ""
        errorText = ""
        shouldShowResults = false
    }
}
