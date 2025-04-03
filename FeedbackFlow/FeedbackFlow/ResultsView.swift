//
//  ResultsView.swift
//  FeedbackFlow
//
//  Created by Greg Delgado on 03.04.25.
//

import SwiftUI

struct ResultsView: View {
    let question: String
    let response: String
    var onAskAnotherQuestion: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            HeaderView()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    questionSection
                    responseSection
                    
                    Spacer(minLength: 20)
                    
                    SubmitButton(title: "Ask Another Question", action: onAskAnotherQuestion)
                        .padding(.vertical, 20)
                }
                .padding(.horizontal, 16)
                .padding(.top, 32)
            }
        }
        .background(Color(.systemGroupedBackground))
        .edgesIgnoringSafeArea(.bottom)
    }
}

private extension ResultsView {
    var questionSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Your Question:")
                .font(.headline)
                .foregroundColor(.primary)
            
            Text(question)
                .font(.body)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
    
    var responseSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Response:")
                .font(.headline)
                .foregroundColor(.primary)
            
            Text(LocalizedStringKey(processResponseText(response)))
                .font(.body)
                .foregroundColor(.primary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
    
    private func processResponseText(_ text: String) -> String {
        var processedText = text
        if processedText.hasPrefix("\"") && processedText.hasSuffix("\"") {
            processedText = String(processedText.dropFirst().dropLast())
        }
        
        processedText = processedText.replacingOccurrences(of: "\\n", with: "\n")
        processedText = processedText.replacingOccurrences(of: "\\\"", with: "\"")
        processedText = processedText.replacingOccurrences(of: "\\t", with: "\t")
        
        return processedText
    }
}
