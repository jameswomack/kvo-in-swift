//
//  NSObject+MVVM.swift
//  KVO
//
//  Created by James Womack on 8/3/14.
//  Copyright (c) 2014 James Womack. All rights reserved.
//

import Foundation

extension NSObject {
  subscript(key: String) -> NSObject? {
    get {
      return self.valueForKeyPath(key) as? NSObject
    }
    set(newValue) {
      self.setValue(newValue, forKeyPath: key)
    }
  }
  func keyPathsForValuesAffectingValueForKey(key: String!) -> NSSet! {
    return nil
  }
  func automaticallyNotifiesObserversForKey(key: String!) -> Bool {
    return true
  }
  func addObserver(observer: NSObject!, forKeyPath keyPath: String!) {
    self.addObserver(observer, forKeyPath: keyPath, options: [], context: nil)
  }
}

