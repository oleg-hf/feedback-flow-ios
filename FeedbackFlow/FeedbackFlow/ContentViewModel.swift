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
    @Published var isLoading = false

    private let networkService = NetworkService()

    func didTapSubmitButton() {
        isLoading = true

        Task {
            do {
                let result = try await networkService.sendPrompt(questionText)

                await MainActor.run {
                    self.responseText = result
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.responseText = "Error: \(error.localizedDescription)"
                    self.isLoading = false
                }
            }
        }
    }
}
