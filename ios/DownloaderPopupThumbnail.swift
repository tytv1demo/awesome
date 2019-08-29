//
//  DownloaderPopupThumbnail.swift
//  AwesomeTyTv
//
//  Created by Trần Tý on 8/28/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import UICircularProgressRing
import RxRelay
import RxSwift

protocol PopupDownloaderThumbnailDelegate {
  func didTapThumbnail()
}
class PopupDownloaderThumbnail: UIView {
  
  public var downloader: Downloader! {
    didSet {
      self.startObseve()
    }
  }
  
  public var logoView: UIImageView!
  public var progressView: UICircularProgressRing!
  
  public var delegate: PopupDownloaderThumbnailDelegate?
  
  private var disposeBag: DisposeBag = DisposeBag()
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    initLayout()
  }
  convenience init(frame: CGRect = CGRect.zero, downloader: Downloader) {
    self.init(frame: frame)
    self.downloader = downloader
  }
  func initLayout() {
    progressView = UICircularProgressRing()
    progressView.style = .ontop
    progressView.valueFormatter = self
    progressView.outerRingColor = .groupTableViewBackground
    progressView.innerRingColor = .green
    self.addSubview(progressView)
    progressView.fullFixInView(self)
    
    logoView = UIImageView(image: UIImage(named: "downloader1"))
    progressView.addSubview(logoView)
    
    logoView.fixInView(progressView, t: 12, r: 12, b: 12, l: 12)
    
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
    self.addGestureRecognizer(tap)
  }
  
  func startObseve(){
    downloader.overalProgressValue.subscribe(onNext: { (progress) in
      self.progressView.startProgress(to: CGFloat(progress * 100), duration: 0.1)
    }).disposed(by: disposeBag)
  }
  
  @objc func didTap(){
    delegate?.didTapThumbnail()
  }
}
extension PopupDownloaderThumbnail: UICircularRingValueFormatter {
  func string(for value: Any) -> String? {
    return ""
  }
}
