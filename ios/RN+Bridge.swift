//
//  RN+Bridge.swift
//  AwesomeTyTv
//
//  Created by Trần Tý on 8/20/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation

class RNBridge:NSObject, RCTBridgeDelegate {
  
  static let shared: RNBridge = RNBridge()
  
  func sourceURL(for bridge: RCTBridge!) -> URL! {
    #if DEBUG
    return URL(string: "http://192.168.1.145:8081/index.bundle?platform=ios")!
    #else
    return URL(string: "http://localhost:8081/index.bundle?platform=ios")!
//    return URL(string: "http://192.168.1.145:8081/index.bundle?platform=ios")!
    //    return Bundle.main.url(forResource: "main", withExtension: "jsbundle")!
    #endif
  }
  var bridge: RCTBridge!
  
  override init() {
    super.init()
    bridge = RCTBridge(delegate: self, launchOptions: [:])
  }
}
