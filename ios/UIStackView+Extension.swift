//
//  UIStackView+Extension.swift
//  AwesomeTyTv
//
//  Created by Trần Tý on 8/29/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import UIKit

extension UIStackView {
  func addBackground(color: UIColor) {
    let subView = UIView(frame: bounds)
    subView.backgroundColor = color
    subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    insertSubview(subView, at: 0)
  }
}
