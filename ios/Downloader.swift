//
//  Downloader.swift
//  AwesomeTyTv
//
//  Created by Trần Tý on 8/28/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import Alamofire
import RxRelay

class Downloader {
  static let shared: Downloader = Downloader()
  
  public var overalProgressValue: BehaviorRelay<Double> = BehaviorRelay(value: 0)
  
  public var tasksRelay: BehaviorRelay<Array<DownloadTask>> = BehaviorRelay(value: [])
  public var completedTasks: BehaviorRelay<Array<DownloadTask>> = BehaviorRelay(value: [])
  
  func pushDownloadTask(rawUrl: String, shouldStartTaskRightAway: Bool = true){
    guard let url: URL = URL(string: rawUrl) else {
      return
    }
    var tasks: Array<DownloadTask> = tasksRelay.value
    let taskID: Int = tasks.count
    let task: DownloadTask = DownloadTask(taskID: taskID, url: url, worker: self)
    tasks.append(task)
    tasksRelay.accept(tasks)
    if shouldStartTaskRightAway {
      task.start()
    }
  }
  func removeTask(_ task: DownloadTask) {
    var tasks: Array<DownloadTask> = tasksRelay.value
    tasks.removeAll { (t) -> Bool in
      return t.taskID == task.taskID
    }
    tasksRelay.accept(tasks)
    caculateOveralProgress()
  }
  
  func caculateOveralProgress(){
    if tasksRelay.value.count == 0 {
      overalProgressValue.accept(0)
      return;
    }
    var progress: Double = 0
    tasksRelay.value.forEach { (task) in
      progress += task.progress?.fractionCompleted ?? 0
    }
    let overal: Double = progress / Double(tasksRelay.value.count)
    overalProgressValue.accept(overal)
  }
  
  func handleOnProgressTask(_ task: DownloadTask, progress: Progress){
    caculateOveralProgress()
  }
  func handleDidDownloadTask(_ task: DownloadTask, response: DefaultDownloadResponse){
    caculateOveralProgress()
  }
  
}
