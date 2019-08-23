//
//  TVIVideo.swift
//  AwesomeTyTv
//
//  Created by Trần Tý on 8/21/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation

class TWIVideoController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
  
    view = ReactNativeHelper.shared.getRNView(name: "TWIVideo")
  }
}
