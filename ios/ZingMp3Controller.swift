//
//  ZingMp3.swift
//  AwesomeTyTv
//
//  Created by Trần Tý on 8/29/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
class ZingMp3Controller: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    let rnView: UIView = ReactNativeHelper.shared.getRNView(name: "ZingMp3")
    view.addSubview(rnView)
    
    let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
    let navigationHeight: CGFloat = navigationController?.navigationBar.frame.height ?? 0
    rnView.fixInView(view, t: statusBarHeight + navigationHeight, r: 0, b: 0, l: 0)
  }
}
