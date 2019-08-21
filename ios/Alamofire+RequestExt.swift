//
//  Alamofire+RequestExt.swift
//  AwesomeTyTv
//
//  Created by Trần Tý on 8/20/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit
import SwiftyJSON

struct RequestBehavior {
  var showSuccessMessage: Bool
  var showErrorMessage: Bool
  var showLoadingIndicator: Bool
}

struct ApiRequestConfig {
  var id: Int;
  var messageConfig: RequestBehavior
}

extension AlamofireImpl {
  
  func revokeMessageConfig(id: Int) -> ApiRequestConfig {
    return requestConfigArray.makeIterator().first(where: { (config) -> Bool in
      return config.id == id
    })!
  }
  
  func getRequestConfig(response:DataResponse<Any>) -> ApiRequestConfig{
    var requestConfig: ApiRequestConfig!
    if let request = response.request {
      let requestID: String = (request.allHTTPHeaderFields?["_id"])!
      
      requestConfig = self.revokeMessageConfig(id: Int(requestID)! )
      
    }
    return requestConfig
  }
  func interceptorResponse(response:DataResponse<Data>, seal: Resolver<JSON>) {
    if let error = response.error {
      
    }
  }
}
