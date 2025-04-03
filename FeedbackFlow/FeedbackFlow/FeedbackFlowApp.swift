//
//  FeedbackFlowApp.swift
//  FeedbackFlow
//
//  Created by Oleg Kirsanov on 02.04.25.
//

import SwiftUI
import SwiftData

@main
struct FeedbackFlowApp: App {
    @State private var modelContainer: ModelContainer

    init() {
        do {
            _modelContainer = State(wrappedValue: try ModelContainer(for: ResultItem.self))
        } catch {
            assertionFailure("Failed to create ModelContainer: \(error)")
            _modelContainer = State(wrappedValue: try! ModelContainer(for: ResultItem.self))
        }
    }

    var body: some Scene {
        WindowGroup {
            let viewModel = ContentViewModel(modelContext: modelContainer.mainContext)
            ContentView(viewModel: viewModel)
        }
        .modelContainer(modelContainer)
    }
}
