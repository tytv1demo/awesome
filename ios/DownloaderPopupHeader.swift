//
//  DownloaderPopupHeader.swift
//  AwesomeTyTv
//
//  Created by Trần Tý on 8/28/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
class PopupDownloaderHeader: UIView {
  public var logoView: UIImageView!
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    initLayout()
  }
  func initLayout() {
    
    self.backgroundColor = .green
    
    logoView = UIImageView(image: UIImage(named: "downloader"))
    self.addSubview(logoView)
    logoView.fixInView(self, w: 80, h: 80)
    
  }
  override func layoutSubviews() {
    super.layoutSubviews()
    logoView.center = self.center
  }
}
