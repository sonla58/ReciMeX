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
}

struct BuildinIOSProvider: NetworkProviderCompatible {
  func request(request: APIRequestCompatible, complete: @escaping (_ request: URLRequest?, _ response: URLResponse?, _ result: Result<Data, Error>) -> Void) -> RequestCancelable {
    do {
      let req = try request.asRequest()
      print(req)
      let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
        if let error = error {
          complete(req, response, .failure(error))
          return
        }
        if let data = data {
          complete(req, response, .success(data))
          return
        }
        complete(req, response, .failure(NSError()))
      }
      task.resume()
      return RequestCancelableBlock {
        task.cancel()
      }
    } catch {
      print(error)
      return NilRequestCancelable()
    }
  }
}
