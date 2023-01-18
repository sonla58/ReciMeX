//
//  APIResponseAdapter.swift
//  ReciMeX
//
//  Created by Anh Son Le on 18/01/2023.
//

import Foundation

protocol APIResponseAdapter {
    associatedtype Value
    
    func toResponse(request: URLRequest?, response: URLResponse?, result: Result<Data, Error>) -> Result<Value, Error>
}

struct APIDataResponse: APIResponseAdapter {
    func toResponse(request: URLRequest?, response: URLResponse?, result: Result<Data, Error>) -> Result<Data, Error> {
        return result
    }
}

// Buildin response handler for JSON format response
struct JSONResponse<Value: Codable>: APIResponseAdapter {
    typealias Value = Value
    
    var jsonDecoder: JSONDecoder
    
    init(decoder: JSONDecoder = JSONDecoder()) {
        self.jsonDecoder = decoder
    }
    
    func toResponse(request: URLRequest?, response: URLResponse?, result: Result<Data, Error>) -> Result<Value, Error> {
        switch result {
        case .success(let data):
            do {
                let decodedValue = try jsonDecoder.decode(Value.self, from: data)
                return .success(decodedValue)
            } catch {
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
