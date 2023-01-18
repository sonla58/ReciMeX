//
//  APIParameterCompatible.swift
//  ReciMeX
//
//  Created by Anh Son Le on 18/01/2023.
//

import Foundation

struct KeyAnyValue {
  var key: String
  var value: Any
}

protocol APIParameterCompatible {
  var parammeters: [KeyAnyValue] { get }
}
