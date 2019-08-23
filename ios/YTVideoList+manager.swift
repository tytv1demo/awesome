//
//  YTVideoList+manager.swift
//  AwesomeTyTv
//
//  Created by Trần Tý on 8/23/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation

@objc(YTVideoListManager)
class YTVideoListManager: RCTEventEmitter {
  static let shared: YTVideoListManager = YTVideoListManager()
  
  var view: YTVideoListController?
  
  override static func requiresMainQueueSetup() -> Bool {
    return false
  }
  
  @objc func pushToDetail(){
    DispatchQueue.main.async {
      YTVideoListManager.shared.view?.goToDetail()
    }
  }
  override func supportedEvents() -> [String]! {
    return []
  }
}
