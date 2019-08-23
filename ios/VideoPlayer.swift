//
//  VideoPlayer.swift
//  AwesomeTyTv
//
//  Created by Trần Tý on 8/23/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import AVFoundation

class VideoPlayer: UIView {
  
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
  }
  
  convenience init(frame: CGRect = CGRect.zero, videoUrl: String) {
    self.init(frame: frame)
    url = URL(string: videoUrl);
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
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    configure()
  }
}
