//
//  NetworkService.swift
//  FeedbackFlow
//
//  Created by Oleg Kirsanov on 03.04.25.
//

import Foundation

struct NetworkService {
    private let url = URL(string: "https://2ffniv7mv25h3wmzhy4f4timf40wbock.lambda-url.ap-southeast-2.on.aws/prompt")!

    func sendPrompt(_ prompt: String) async throws -> String {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: String] = ["prompt": prompt]
        request.httpBody = try JSONEncoder().encode(body)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }

        guard let resultString = String(data: data, encoding: .utf8) else {
            throw URLError(.cannotDecodeRawData)
        }

        return resultString
    }
}
