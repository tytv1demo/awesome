//
//  YT+VideoList.swift
//  AwesomeTyTv
//
//  Created by Trần Tý on 8/20/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation

class YTVideoListController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    view = ReactNativeHelper.shared.getRNView(name: "YTVideoList")
   
  }
}
