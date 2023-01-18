//
//  ReciMeAPIBuilder.swift
//  ReciMeX
//
//  Created by Anh Son Le on 18/01/2023.
//

import Foundation

struct ReciMeAPIBuilder {
  static let baseURL = "https://dev.api.recime.app/web-api"
  var method: HTTPMethod
  var path: String
  var queryParams: APIParameterCompatible?
}

extension ReciMeAPIBuilder: APIRequestCompatible {
  private func asURL() throws -> URL {
    
    var baseURL: String {
      ReciMeAPIBuilder.baseURL
    }
    
    guard var url = URL(string: baseURL) else {
      throw URLError(URLError.Code.badURL)
    }
    url.appendPathComponent(path)
    guard var urlComponent = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
      throw URLError(URLError.Code.badURL)
    }
    let queryItems = queryParams?.parammeters.map { (item) -> URLQueryItem in
      URLQueryItem(name: item.key, value: "\(item.value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
    }
    urlComponent.queryItems = queryItems
    return try urlComponent.asURL()
  }
  
  var url: URLConvertible {
    do {
      return try self.asURL()
    } catch {
      fatalError(error.localizedDescription)
    }
  }
  
  var headers: APIHeaderCompatible {
    return [:]
  }
  
  var urlBodyParams: APIBodyCompatible? {
    return nil
  }
  
  var cachePolicy: URLRequest.CachePolicy {
    return .useProtocolCachePolicy
  }
  
  var timeout: TimeInterval {
    return 60
  }
}
