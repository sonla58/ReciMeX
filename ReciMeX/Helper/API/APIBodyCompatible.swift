//
//  APIBodyCompatible.swift
//  ReciMeX
//
//  Created by Anh Son Le on 18/01/2023.
//

import Foundation

protocol APIBodyCompatible {
  func asHTTPBody() throws -> APIBodyType
}

enum APIBodyType {
//  case single(Data)
//  case stream(InputStream)
//  case formData(MultipartFormData)
}
