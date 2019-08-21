//
//  RN+Utils.swift
//  AwesomeTyTv
//
//  Created by Trần Tý on 8/20/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
class ReactNativeHelper {
  static let shared: ReactNativeHelper = ReactNativeHelper()
  
  var bridge: RCTBridge = RNBridge.shared.bridge
  
  func getRNView(name: String, initialProperties: [AnyHashable: Any]? = nil) -> RCTRootView {
    let view: RCTRootView = RCTRootView(bridge: bridge, moduleName: name, initialProperties: initialProperties)
    return view
  }
}
