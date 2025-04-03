//
//  ResultItem.swift
//  FeedbackFlow
//
//  Created by Oleg Kirsanov on 03.04.25.
//

import SwiftData

@Model
class ResultItem {
    var question: String
    var result: String

    var name: String {
        let words = question.split(separator: " ")
        let prefixWords = words.prefix(7).joined(separator: " ")

        if words.count > 7 {
            return prefixWords + "…"
        } else {
            return prefixWords
        }
    }

    init(question: String, result: String) {
        self.question = question
        self.result = result
    }
}
