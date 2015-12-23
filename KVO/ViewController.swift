//
//  ViewController.swift
//  KVO
//
//  Created by James Womack on 8/3/14.
//  Copyright (c) 2014 James Womack. All rights reserved.
//

import UIKit

class ViewController : UIViewController {
    @IBOutlet var fooTextView : UILabel?
    @IBOutlet var inputTextView : UITextField?
    
    // The '!' prevents "Property 'self._viewModel' not initialized at super.init call"
    var _viewModel : ViewModel!
    var viewModel : ViewModel {
        get {
            if(_viewModel == nil){
                _viewModel = ViewModel(view: self)
            }
            return _viewModel
        }
    }
    
    // This is called during the Storyboard decoding process
    // and was necessary to allow strong properties such as
    // `_viewModel` on a UIViewController subclass
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidAppear(animated: Bool) {
        self.viewModel.foo = "A string set on the model"
        self.inputTextView!.addTarget(self, action: "updateInputTextView", forControlEvents: .EditingChanged)
        super.viewDidAppear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self._viewModel = nil
    }
    
    func updateInputTextView() {
        self.inputTextView!.willChangeValueForKey("text")
        self.inputTextView!.didChangeValueForKey("text")
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        let text = (object as! ViewModel)[keyPath!] as! NSString
        let viewKeyPath = keyPath! + "TextView"
        if self[viewKeyPath] is UILabel {
            let textField : UILabel = self[viewKeyPath] as! UILabel
            textField.text = (textField.text != text)  ? text as String : textField.text
        } else if self[viewKeyPath] is UITextField {
            let textField : UITextField = self[viewKeyPath] as! UITextField
            textField.text = (textField.text != text) ? text as String : textField.text
        }
    }
}

