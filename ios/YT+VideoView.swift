//
//  YT+VideoView.swift
//  AwesomeTyTv
//
//  Created by Trần Tý on 8/23/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import AVKit

class YTVideoViewController: UIViewController {
  private var popupDownloader: PopupDownloader!
  
  var playerView: VideoPlayer!
  override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = .white
      playVideo()
    
    popupDownloader = PopupDownloader()
    popupDownloader.isThumbnailMode = false
  }
  func playVideo(){
    playerView = VideoPlayer(videoUrl: "http://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v")
    playerView.frame = view.bounds
    view.addSubview(playerView)
  }
  
}
