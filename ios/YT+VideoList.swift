//
//  YT+VideoList.swift
//  AwesomeTyTv
//
//  Created by Trần Tý on 8/20/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import AVKit

class YTVideoListController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    YTVideoListManager.shared.view = self
    view = ReactNativeHelper.shared.getRNView(name: "YTVideoList")

  }
  func goToDetail(){
    let vc: UIViewController = YTVideoViewController()
    navigationController?.pushViewController(vc, animated: true)
  }

}
