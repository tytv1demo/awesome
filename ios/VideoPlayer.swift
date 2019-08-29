//
//  VideoPlayer.swift
//  AwesomeTyTv
//
//  Created by Trần Tý on 8/23/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import AVFoundation
import Alamofire

class VideoPlayer: UIView {
  
  public var downloadBtn: UIButton!
  public var dowloadProgress: UIProgressView!
  
  fileprivate var url: URL!
  
  fileprivate var player: AVPlayer!
  fileprivate var playerLayer: AVPlayerLayer!
  fileprivate var avAsset: AVAsset!
  fileprivate var avPlayerItem: AVPlayerItem!
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    initLayout()
  }
  
  convenience init(frame: CGRect = CGRect.zero, videoUrl: String) {
    self.init(frame: frame)
    url = URL(string: videoUrl);
  }
  func initLayout(){
    downloadBtn = UIButton()
    downloadBtn.setTitle("Down", for: [])
    downloadBtn.backgroundColor = .red
    downloadBtn.addTarget(self, action: #selector(download), for: .touchUpInside)
    self.addSubview(downloadBtn)
    downloadBtn.fixWithWHLT(self, w: 50, h: 50, l: 15, t: 100)
    
    dowloadProgress = UIProgressView(progressViewStyle: .default)
    self.addSubview(dowloadProgress)
    dowloadProgress.fixInView(self, t: 180, r: 5, l: 5, h: 5)
  }
  func configure(){
    avAsset = AVAsset(url: url)
    avPlayerItem = AVPlayerItem(asset: avAsset)
    player = AVPlayer(playerItem: avPlayerItem)
    
    playerLayer = AVPlayerLayer(player: player)
    playerLayer.frame = self.bounds
    
    self.layer.addSublayer(playerLayer)
    player.play()
  }
  
  @objc func download(){
    Downloader.shared.pushDownloadTask(rawUrl: url.absoluteString)
  }
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    configure()
  }
  
}
