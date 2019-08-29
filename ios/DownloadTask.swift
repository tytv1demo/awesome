//
//  DownloadTask.swift
//  AwesomeTyTv
//
//  Created by Trần Tý on 8/28/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import Alamofire

protocol DownloadTaskDelegate {
  func downloadTask(_ downloadTask: DownloadTask, onProgress progress: Progress)
  func downloadTask(_ downloadTask: DownloadTask, didDownload response: DefaultDownloadResponse)
}

class DownloadTask {
  var taskID: Int
  var url: URL
  var worker: Downloader
  
  var request: Request?
  var isPausing: Bool = false
  //MARK: State
  var progress: Progress?
  
  var delegate: DownloadTaskDelegate?
  
  init(taskID: Int, url: URL, worker: Downloader, delegate: DownloadTaskDelegate? = nil) {
    self.taskID = taskID
    self.url = url
    self.worker = worker
  }
  func start() {
    request = Alamofire.download(url)
      .downloadProgress { (progress) in
        self.delegate?.downloadTask(self, onProgress: progress)
        self.worker.handleOnProgressTask(self, progress: progress)
        self.progress = progress
      }.response { (response) in
        self.delegate?.downloadTask(self, didDownload: response)
        self.worker.handleDidDownloadTask(self, response: response)
    }
  }
  
  func suspend() {
    request?.suspend()
    isPausing = true
  }
  
  func resume()  {
    request?.resume()
    isPausing = false
  }
}
