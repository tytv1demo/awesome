//
//  DownloaderPopupThumbnail.swift
//  AwesomeTyTv
//
//  Created by Trần Tý on 8/28/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
protocol PopupDownloaderThumbnailDelegate {
  func didTapThumbnail()
}
class PopupDownloaderThumbnail: UIView {
  public var logoView: UIImageView!
  
  public var delegate: PopupDownloaderThumbnailDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    initLayout()
  }
  func initLayout() {
    
    logoView = UIImageView(image: UIImage(named: "downloader"))
    self.addSubview(logoView)
    logoView.fullFixInView(self)
    
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
    self.addGestureRecognizer(tap)
  }
  
  @objc func didTap(){
    delegate?.didTapThumbnail()
  }
  override func layoutSubviews() {
    super.layoutSubviews()
    logoView.center = self.center
  }
}
