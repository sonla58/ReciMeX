//
//  APIHeaderCompatible.swift
//  ReciMeX
//
//  Created by Anh Son Le on 18/01/2023.
//

import Foundation

protocol APIHeaderCompatible {
  var headers: [String: String] { get }
}

//MARK: - Convenience

extension Dictionary: APIHeaderCompatible where Key == String, Value == String {
  var headers: [String : String] {
    return self
  }
}

extension APIHeaderCompatible {
  func with(extraHeader ext: APIHeaderCompatible) -> [String: String] {
    return self.headers.merging(ext.headers) { l, r in
      return l
    }
  }
}
