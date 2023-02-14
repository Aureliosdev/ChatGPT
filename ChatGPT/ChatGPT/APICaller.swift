//
//  APICaller.swift
//  ChatGPT
//
//  Created by Aurelio Le Clarke on 14.02.2023.
//

import Foundation
import OpenAISwift
final class APICaller {
    
    static let shared = APICaller()
    
    private var client: OpenAISwift?
    
    let apiKey = "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"
 
    init() {
        
    }
    
    public func setup() {
        client = OpenAISwift(authToken: apiKey)
    }
    
    
    func send(text: String, completion: @escaping (Result<String, Error>) -> Void) {
       
        client?.sendCompletion(with: text ,model: .gpt3(.ada), maxTokens: 100,completionHandler: { result in
            
            switch result {
            case .success(let  model):
                print(String(describing: model.choices))
                let output = model.choices.first?.text ?? ""
                completion(.success(output))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
