//
//  UIView+Extension.swift
//  AwesomeTyTv
//
//  Created by Trần Tý on 8/28/19.
//  Copyright © 2019 Facebook. All rights reserved.
//


// MARK: Layout
extension UIView {
  func fixInView(_ container: UIView, t: CGFloat = -1, r: CGFloat = -1, b: CGFloat = -1, l: CGFloat = -1, w: CGFloat = -1, h: CGFloat = -1 ) -> Void{

    self.translatesAutoresizingMaskIntoConstraints = false;
    if t > -1 {
      NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: t).isActive = true
    }
    if r > -1 {
      NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: -r).isActive = true
    }
    if b > -1 {
      NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: -b).isActive = true
    }
    if l > -1 {
      NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: l).isActive = true
    }
    if w > -1 {
      NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: w).isActive = true
    }
    if h > -1 {
      NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: h).isActive = true
    }
  }
  func fullFixInView(_ container: UIView, t: CGFloat = 0, r: CGFloat = 0, b: CGFloat = 0, l: CGFloat = 0) -> Void{
    self.translatesAutoresizingMaskIntoConstraints = false;
    //        self.frame = container.frame;
    container.addSubview(self);
    NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: l).isActive = true
    NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: r).isActive = true
    NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: t).isActive = true
    NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: b).isActive = true
  }
  func fixWithWHLT(_ container: UIView, w: CGFloat = 0, h: CGFloat = 0, l: CGFloat = 0, t: CGFloat = 0) -> Void{
    self.translatesAutoresizingMaskIntoConstraints = false;
    container.addSubview(self);
    NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: l).isActive = true
    NSLayoutConstraint(item: self, attribute: .width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: w).isActive = true
    NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: t).isActive = true
    NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: h).isActive = true
  }
  
  func addBoderRadius(radius: CGFloat){
      self.layer.masksToBounds = true
      self.layer.cornerRadius = radius
  }
  
  func addShadow(){
    self.layer.shadowColor = UIColor.gray.cgColor
    self.layer.shadowOpacity = 0.3
    self.layer.shadowOffset = CGSize.zero
    self.layer.shadowRadius = 6

  }
}
