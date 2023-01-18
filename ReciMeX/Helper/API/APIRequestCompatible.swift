//
//  APIRequestCompatible.swift
//  ReciMeX
//
//  Created by Anh Son Le on 18/01/2023.
//

import Foundation

enum APIError: Swift.Error {
  case invalidURL(url: URLConvertible)
}

enum HTTPMethod: String {
  case get  = "GET"
  case post = "POST"
}

protocol URLConvertible {
  func asURL() throws -> URL
}

extension String: URLConvertible {
  func asURL() throws -> URL {
    guard let url = URL(string: self) else { throw APIError.invalidURL(url: self) }
    return url
  }
}

extension URL: URLConvertible {
  func asURL() throws -> URL { self }
}

extension URLComponents: URLConvertible {
  func asURL() throws -> URL {
    guard let url = url else { throw APIError.invalidURL(url: self) }
    
    return url
  }
}

protocol APIRequestCompatible {
  var method: HTTPMethod { get }
  var url: URLConvertible { get }
  var headers: APIHeaderCompatible { get }
  var urlBodyParams: APIBodyCompatible? { get }
  var cachePolicy: URLRequest.CachePolicy { get }
  var timeout: TimeInterval { get }
}

extension APIRequestCompatible {
  func asRequest() throws -> URLRequest {
    // Crete url component include query params
    let absUrl = try url.asURL()
    
    // Create URLRequest
    var req = URLRequest(url: absUrl, cachePolicy: cachePolicy, timeoutInterval: timeout)
    
    /// add HTTP method
    req.httpMethod = method.rawValue
    
    /// add HTTP header
    for key in (headers.headers).keys {
      req.setValue(headers.headers[key] ?? "", forHTTPHeaderField: key)
    }
    
    /// TODO: - Handle body
    
    return req
  }
  
  func use<ResponseAdapter: APIResponseAdapter>(provider: NetworkProviderCompatible, responseAdapter: ResponseAdapter) -> APIAssemble<ResponseAdapter> {
    return APIAssemble(provider: provider, request: self, responseAdapter: responseAdapter)
  }
}
