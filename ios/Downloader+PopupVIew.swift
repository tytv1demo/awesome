//
//  Downloader+PopupVIew.swift
//  AwesomeTyTv
//
//  Created by Trần Tý on 8/28/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation

class PopupDownloader: UIView {
  
  static let THUMBNAIL_SIZE: CGFloat = 50
  
  public var contentView: UIView!
  public var header: PopupDownloaderHeader!
  public var thumbnail: PopupDownloaderThumbnail!
  public var closeIcon: UIButton!
  
  private var thumbnailFrame: CGRect!
  
  // MARK: Render state
  public var isThumbnailMode: Bool = true {
    didSet {
      self.togglePopup()
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    initLayout()
  }
  
  func initLayout() {
    
    self.backgroundColor = .clear
    self.addBoderRadius(radius: 8)
    
    contentView = UIView();
    contentView.backgroundColor = .white
    contentView.addBoderRadius(radius: 8)
    contentView.addShadow()
    
    self.addSubview(contentView)
    contentView.fixInView(self, t: 100, r: 20, l: 20, h: 500)
    
    header = PopupDownloaderHeader()
    contentView.addSubview(header)
    header.fixInView(contentView, t: 0, r: 0, l: 0, h: 200)
    
    closeIcon = UIButton()
    closeIcon.setBackgroundImage(UIImage(named: "close-circle"), for: [])
    self.addSubview(closeIcon)
    closeIcon.fixInView(self, b: 15, w: 35, h: 40)
    //    closeIcon.fixInView(contentView, b: 15)
    closeIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    closeIcon.addTarget(self, action: #selector(requestClose), for: [.touchUpInside])

    thumbnail = PopupDownloaderThumbnail()
    self.addSubview(thumbnail)
    thumbnail.fullFixInView(self)
    self.thumbnail.isHidden = true
    thumbnail.delegate = self
    
    let pan: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan))
    self.addGestureRecognizer(pan)
    
    if let window = UIApplication.shared.keyWindow {
      window.addSubview(self)
      thumbnailFrame = CGRect(x: window.bounds.width - PopupDownloader.THUMBNAIL_SIZE, y: window.bounds.height * 0.5, width: PopupDownloader.THUMBNAIL_SIZE, height: PopupDownloader.THUMBNAIL_SIZE)
    }
  }
}
extension PopupDownloader: PopupDownloaderThumbnailDelegate {
  func didTapThumbnail() {
    self.isThumbnailMode = false
  }
  
  @objc func togglePopup() {
    onModeChange()
    guard let window: UIView = UIApplication.shared.keyWindow else {
      return
    }
    let nextBgAlpha: CGFloat = isThumbnailMode ? 0 : 0.5
    let nextFrame: CGRect = isThumbnailMode ? thumbnailFrame : window.bounds
    UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.curveEaseInOut], animations: {
      self.frame = nextFrame
      self.backgroundColor = UIColor.gray.withAlphaComponent(nextBgAlpha)
    }, completion: nil)
    
  }
  
  func onModeChange(){

    self.contentView.isHidden = isThumbnailMode
    self.closeIcon.isHidden = isThumbnailMode
    self.thumbnail.isHidden = !isThumbnailMode
  }
  @objc func requestClose(){
    isThumbnailMode = true
  }
  @objc func onPan(_ sender: UIPanGestureRecognizer){
    if !isThumbnailMode {
      return
    }
    let haflSize : CGFloat = PopupDownloader.THUMBNAIL_SIZE * 0.5
    let window: UIView = self.superview!
    let currentPoint: CGPoint = self.center
    let translatePoint: CGPoint = sender.translation(in: self.superview)
    let state: UIPanGestureRecognizer.State = sender.state
    switch state {
    case .changed:
      self.center = CGPoint(x: currentPoint.x + translatePoint.x, y: currentPoint.y + translatePoint.y)
      sender.setTranslation(CGPoint.zero, in: self.superview)
      break
    case .ended:
      let isOnRightSide: Bool = currentPoint.x >  window.bounds.width * 0.5
      
      var y: CGFloat = currentPoint.y
      
      let isOverHeightSide: Bool = currentPoint.y > window.bounds.height - haflSize
      if isOverHeightSide {
        y = window.bounds.height - haflSize
      }
      
      let isOffHeightSide: Bool = currentPoint.y < 0
      if isOffHeightSide {
        y = haflSize
      }
      
      self.center = CGPoint(x: isOnRightSide ? window.bounds.width - haflSize : haflSize, y: y)
 
      thumbnailFrame = self.frame
      break;
    default:
      return
    }
  }
}
