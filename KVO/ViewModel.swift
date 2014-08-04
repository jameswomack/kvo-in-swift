//
//  ViewModel.swift
//  KVO
//
//  Created by James Womack on 8/3/14.
//  Copyright (c) 2014 James Womack. All rights reserved.
//

import Foundation

func remove(needle: String!, haystack: String!) ->String {
  return needle.stringByReplacingOccurrencesOfString(haystack, withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
}

let SUFFIX : String = "TextView.text"

class ViewModel : NSObject {
  var foo: NSString = "fooString"
  var input: NSString = "inputString"
  
  init(view: ViewController) {
    super.init()
    for key in ["foo","input"] {
      self.addObserver(view, forKeyPath: key)
      view.addObserver(self, forKeyPath: key + SUFFIX)
    }
  }
  
  override func observeValueForKeyPath(keyPath: String!, ofObject object: AnyObject!, change: NSDictionary!, context: CMutableVoidPointer) {
    var view = object as ViewController
    var string = view[keyPath] as NSString
    var modelKeyPath = remove(keyPath, SUFFIX)
    if(self[modelKeyPath] != string) {
      self[modelKeyPath] = string
      println(string)
    }
  }
}