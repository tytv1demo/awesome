//
//  Alamofire+RequestAdapter.swift
//  AwesomeTyTv
//
//  Created by Trần Tý on 8/20/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import Alamofire

class AccessTokenAdapter: RequestAdapter {
  private let accessToken: String
  
  init(accessToken: String) {
    self.accessToken = accessToken
  }
  
  func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
    var urlRequest = urlRequest
    
    if let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix("https://httpbin.org") {
      urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
      
    }
    
    return urlRequest
  }
}
