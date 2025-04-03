//
//  ContentViewModel.swift
//  FeedbackFlow
//
//  Created by Oleg Kirsanov on 02.04.25.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var questionText = ""
    @Published var responseText = ""
    @Published var errorText = ""
    @Published var isLoading = false
    @Published var shouldShowResults = false

    private let networkService = NetworkService()

    func didTapSubmitButton() {
        isLoading = true

        Task {
            do {
                let result = try await networkService.sendPrompt(questionText)

                await MainActor.run {
                    self.responseText = result
                    self.isLoading = false
                    self.shouldShowResults = true
                }
            } catch {
                await MainActor.run {
                    self.errorText = "Error: \(error.localizedDescription)"
                    self.isLoading = false
                    self.shouldShowResults = false
                }
            }
        }
    }
    
    func resetForm() {
        questionText = ""
        responseText = ""
        errorText = ""
        shouldShowResults = false
    }
}
