//
//  DowloadTaskCollection.swift
//  AwesomeTyTv
//
//  Created by Trần Tý on 8/28/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
class DownloadTaskCollectionView: UIView {
  
  
  var collectionView: UICollectionView!
  var collectionLayout: UICollectionViewFlowLayout!
  
  public var downloader: Downloader!
  public var fullModeFrame: CGRect = CGRect.zero
  // MARK: renderState
  
  var source: Array<DownloadTask> = [] {
    didSet {
      self.didUpdateDataSource()
    }
  }
  var isFullMode: Bool! {
    didSet {
      self.didUpdateDataSource()
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    initLayout()
  }
  
  func initLayout(){
    collectionLayout = UICollectionViewFlowLayout()
    collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    collectionLayout.scrollDirection = .vertical
  
    collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionLayout)
    collectionView.register(DownloaderItem.self, forCellWithReuseIdentifier: DownloaderItem.CELL_NAME)
    collectionView.dataSource = self
    collectionView.delegate = self
    let bgView = UIView()
    collectionView.backgroundColor = .groupTableViewBackground
    collectionView.backgroundView = bgView
    
    self.addSubview(collectionView)
    collectionView.fullFixInView(self)
  }
  
  func didUpdateDataSource(){
    if let isFullMode = self.isFullMode, isFullMode {
      collectionView.reloadData()
    }
  }
}

extension DownloadTaskCollectionView: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let sectionInset = (collectionViewLayout as! UICollectionViewFlowLayout).sectionInset
    let _ = collectionView.dequeueReusableCell(withReuseIdentifier: DownloaderItem.CELL_NAME, for: indexPath) as! DownloaderItem
    let referenceHeight: CGFloat = 65.125 // Approximate height of your cell

    let referenceWidth = frame.width
      - 10
      - sectionInset.left
      - sectionInset.right
      - collectionView.contentInset.left
      - collectionView.contentInset.right
    return CGSize(width: referenceWidth, height: referenceHeight)
  }
}

extension DownloadTaskCollectionView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return source.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView
      .dequeueReusableCell(withReuseIdentifier: DownloaderItem.CELL_NAME, for: indexPath) as! DownloaderItem
    
    cell.task = source[indexPath.item]
    cell.downloader = downloader
    return cell
  }
  
  
}
