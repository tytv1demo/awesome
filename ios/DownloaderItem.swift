//
//  DownloaderItem.swift
//  AwesomeTyTv
//
//  Created by Trần Tý on 8/28/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import UICircularProgressRing
import Alamofire

class DownloaderItem: UICollectionViewCell {
  static let CELL_NAME: String = "DownloaderItem"
  
  var stackView: UIStackView!
  var progressView: UICircularProgressRing!
  var infoView: UIView!
  var taskName: UILabel!
  var taskRemain: UILabel!
  var taskControlStack: UIStackView!
  var pauseContinueBtn: UIButton!
  var stopBtn: UIButton!
  
  public var task: DownloadTask! {
    didSet {
      self.configure()
    }
  }
  public var downloader: Downloader!
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  func configure() {
    
    contentView.backgroundColor = .white
    contentView.fixInView(self, t: 5, r: 5, b: 5)
    contentView.addBoderRadius(radius: 8)
    
    stackView = UIStackView()
    stackView.spacing = 10
    stackView.distribution = .fill
    stackView.axis = .horizontal
    
    progressView = UICircularProgressRing()
    progressView.style = .ontop
    stackView.addArrangedSubview(progressView)
    progressView.fixInView(self, w: 65.125)
    progressView.outerRingColor = .groupTableViewBackground
    progressView.innerRingColor = .purple
    progressView.fontColor = .purple
    if let progress = task.progress {
      progressView.startProgress(to: CGFloat(progress.fractionCompleted * 100), duration: 0)
    }
    
    infoView = UIView()
    stackView.addArrangedSubview(infoView)
    
    taskName = UILabel()
    taskName.text = task.url.absoluteString
    infoView.addSubview(taskName)
    taskName.fixInView(infoView, t:0, r: 0, l: 0, w: contentView.frame.width - 65.125)
    taskName.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    taskName.numberOfLines = 0
    taskName.sizeToFit()
    
    taskRemain = UILabel()
    taskRemain.font = UIFont.systemFont(ofSize: 13, weight: .thin)
    infoView.addSubview(taskRemain)
    taskRemain.fixInView(infoView, r: 0, l: 0)
    NSLayoutConstraint(item: taskRemain!, attribute: .top, relatedBy: .equal, toItem: taskName, attribute: .bottom, multiplier: 1, constant: 5).isActive = true
    taskRemain.text = "Remain Time:"
    
    taskControlStack = UIStackView()
    taskControlStack.axis = .horizontal
    taskControlStack.spacing = 15
    infoView.addSubview(taskControlStack)
    taskControlStack.fixInView(infoView, r: 0, b: 0, l: 0)
    NSLayoutConstraint(item: taskControlStack!, attribute: .top, relatedBy: .equal, toItem: taskRemain, attribute: .bottom, multiplier: 1, constant: 5).isActive = true
    
    pauseContinueBtn = UIButton()
    pauseContinueBtn.setBackgroundImage(UIImage(named: "pause"), for: [])
    pauseContinueBtn.addTarget(self, action: #selector(onPauseOrContinue), for: [.touchUpInside])
    taskControlStack.addArrangedSubview(pauseContinueBtn)
    pauseContinueBtn.fixInView(self, w: 30, h: 30)
    
    stopBtn = UIButton()
    stopBtn.addTarget(self, action: #selector(onStop), for: [.touchUpInside])
    stopBtn.setBackgroundImage(UIImage(named: "stop"), for: [])
    taskControlStack.addArrangedSubview(stopBtn)
    stopBtn.fixInView(self, w: 30, h: 30)
    
    taskControlStack.addArrangedSubview(UIView())
    
    contentView.addSubview(stackView)
    stackView.fixInView(contentView, t: 8, r: 8, b: 8, l: 8)
    
    task.delegate = self
    animate()
  }
  @objc func onPauseOrContinue(){
    
    if task.isPausing {
      pauseContinueBtn.setBackgroundImage(UIImage(named: "pause"), for: [])
      task.resume()
    }else{
      pauseContinueBtn.setBackgroundImage(UIImage(named: "continue"), for: [])
      task.suspend()
    }
    
  }
  @objc func onStop(){
    guard let request = task.request else {
      return
    }
    request.cancel()
  }
  
  func animate(){
    let delay: TimeInterval = TimeInterval.random(in: 0.2...0.5)
    contentView.transform = CGAffineTransform(translationX: 0, y: 50)
    contentView.layer.opacity = 0
    UIView.animate(withDuration: 0.2, delay: delay, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [.curveLinear], animations: {
      self.contentView.transform = .identity
      self.contentView.layer.opacity = 1
    }, completion: nil)
  }
}
extension DownloaderItem : DownloadTaskDelegate {
  
  func downloadTask(_ downloadTask: DownloadTask, onProgress progress: Progress) {
    progressView.startProgress(to: CGFloat(progress.fractionCompleted) * 100, duration: 0.1)
    
    if let timeRemain = progress.estimatedTimeRemaining {
      taskRemain.text = timeRemain.description
    }
  }
  
  func downloadTask(_ downloadTask: DownloadTask, didDownload response: DefaultDownloadResponse) {
    
  }
}
