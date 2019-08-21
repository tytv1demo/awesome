//
//  Alamofire+Implementation.swift
//  AwesomeTyTv
//
//  Created by Trần Tý on 8/20/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit
import SwiftyJSON

class AlamofireImpl: NSObject {
  static let shared: AlamofireImpl = AlamofireImpl()
  
  var session: SessionManager
  var requestConfigArray: [ApiRequestConfig] = []
  
  override init() {
    session = SessionManager()
  }
  
  convenience init(session: SessionManager = Alamofire.SessionManager.default) {
    self.init()
    self.session = session
  }
  
  func postJSON(
    url: URLConvertible,
    parameters: Parameters,
    encoding: ParameterEncoding,
    headers: HTTPHeaders
    ) -> Promise<JSON> {
    return Promise<JSON> { seal  in
      session.request(url, method: .post, parameters: parameters, encoding: encoding, headers: headers)
        .validate(statusCode: 200...200)
        .responseData(completionHandler: { (response) in
          self.interceptorResponse(response: response, seal: seal)
        })
      
    }
  }
  
}
