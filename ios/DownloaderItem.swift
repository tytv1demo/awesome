//
//  DownloaderItem.swift
//  AwesomeTyTv
//
//  Created by Trần Tý on 8/28/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
class DownloaderItem: UICollectionViewCell {
  static let CELL_NAME: String = "DownloaderItem"
  
  private var url: URL!
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    initLayout()
  }
  convenience init(frame: CGRect = CGRect.zero, url: String) {
    self.init(frame: frame)
    self.url = URL(string: url)!
  }
  func initLayout() {
   
  }
}
