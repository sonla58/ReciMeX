//
//  APIAssemble.swift
//  ReciMeX
//
//  Created by Anh Son Le on 18/01/2023.
//

import Foundation

struct APIAssemble<ResponseAdapter: APIResponseAdapter> {
    var networkProvider: NetworkProviderCompatible
    var request: APIRequestCompatible
    var responseAdapter: ResponseAdapter
    
    init(provider: NetworkProviderCompatible, request: APIRequestCompatible, responseAdapter: ResponseAdapter) {
        self.networkProvider = provider
        self.request = request
        self.responseAdapter = responseAdapter
    }
    
    @discardableResult
    func execute(completed: @escaping (_ result: Result<ResponseAdapter.Value, Error>)->Void) -> RequestCancelable {
        networkProvider.request(request: request) { (urlRequest, urlResponse, result) in
            DispatchQueue.main.async {
                completed(responseAdapter.toResponse(request: urlRequest, response: urlResponse, result: result))
            }
        }
    }
}
