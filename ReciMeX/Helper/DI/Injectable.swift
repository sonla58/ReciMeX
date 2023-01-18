//
//  Injectable.swift
//  ReciMeX
//
//  Created by Anh Son Le on 18/01/2023.
//

import Foundation

enum InjectingMode {
  case new
  case shared
}

struct DIContainer {
  private(set) static var factories: [ObjectIdentifier : () -> Any] = [:]
  
  private(set) static var shared: [ObjectIdentifier: Any] = [:]
  
  private init() {}
  
  static func register<T>(_ type: T.Type = T.self, _ factory: @escaping () -> T) {
    self.factories[ObjectIdentifier(type)] = factory
  }
  
  static func register<T>(_ type: T.Type, _ factory: @autoclosure @escaping () -> T) {
    self.factories[ObjectIdentifier(type)] = factory
  }
  
  static func locate<T>(_ type: T.Type, locatingMode: InjectingMode) -> T {
    let key = ObjectIdentifier(type)
    
    switch locatingMode {
    case .new:
      return self.factories[key]!() as! T
    case .shared:
      guard let sharedInstance = self.shared[key] as? T else {
        let instance = self.factories[key]!() as! T
        
        self.shared[key] = instance
        
        return instance
      }
      
      return sharedInstance
    }
  }
}

@propertyWrapper
struct Injectable<Service> {
  
  let mode: InjectingMode
  
  init(_ mode: InjectingMode = .shared) {
    self.mode = mode
  }
  
  var wrappedValue: Service {
    get {
      return DIContainer.locate(Service.self, locatingMode: mode)
    }
  }
}
