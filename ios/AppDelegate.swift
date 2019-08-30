//
//  AppDelegate.swift
//  AwesomeTyTv
//
//  Created by Trần Tý on 8/19/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import UIKit
import TwilioVideo

@UIApplicationMain
class AppDelegate: UIResponder {
  var window: UIWindow?
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    TwilioVideo.audioDevice = TVIDefaultAudioDevice()
    let rootViewController: UIViewController = ZingMp3Controller()
    
    let nav: UINavigationController = UINavigationController(rootViewController: rootViewController)
    
    self.window = UIWindow(frame: UIScreen.main.bounds)
    self.window?.rootViewController = nav
    self.window?.makeKeyAndVisible()
    
    return true
  }

}

extension AppDelegate: UIApplicationDelegate {

}
