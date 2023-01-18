//
//  NetworkProviderCompatible.swift
//  ReciMeX
//
//  Created by Anh Son Le on 18/01/2023.
//

import Foundation

protocol RequestCancelable {
  func __cancel()
}

struct NilRequestCancelable: RequestCancelable {
  func __cancel() {
    // Nothing
  }
}

struct RequestCancelableBlock: RequestCancelable {
  let block: () -> Void
  
  func __cancel() {
    block()
  }
}

protocol NetworkProviderCompatible {
  func request(request: APIRequestCompatible, complete: @escaping (_ request: URLRequest?, _ response: URLResponse?, _ result: Result<Data, Error>) -> Void) -> RequestCancelable
  func upload(request: APIRequestCompatible, complete: @escaping (_ request: URLRequest?, _ response: URLResponse?, _ result: Result<Data, Error>) -> Void) -> RequestCancelable
}
