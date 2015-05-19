//
//  MailboxViewController.swift
//  codepath-mailbox
//
//  Created by Patrick Dugan on 5/16/15.
//  Copyright (c) 2015 dailydoog. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {
    
    @IBOutlet var menuView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var openMenuOffset = CGFloat(300)
    var mainViewCenter = CGPoint()
    var messageCenter = CGPoint()
    var leftViewOrigin = CGPoint()
    var rightViewOrigin = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: 320, height: 2240)
        
        self.mainView.frame.origin.x = 0
        self.mainViewCenter = self.mainView.center
        
        var edgePanGestureLeft = UIScreenEdgePanGestureRecognizer(target: self, action: "onMenuSwipeOpen:")
        edgePanGestureLeft.edges = UIRectEdge.Left
        self.mainView.addGestureRecognizer(edgePanGestureLeft)
        
        var edgePanGestureRight = UIScreenEdgePanGestureRecognizer(target: self, action: "onMenuSwipeClose:")
        edgePanGestureRight.edges = UIRectEdge.Right
        self.mainView.addGestureRecognizer(edgePanGestureRight)
        
    }
    
    func onMenuSwipeOpen(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        var translation = gestureRecognizer.translationInView(view)
        var velocity = gestureRecognizer.velocityInView(view)
        
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            
        }
        else if gestureRecognizer.state == UIGestureRecognizerState.Changed {
            self.mainView.center.x = translation.x + mainViewCenter.x
        }
        else if gestureRecognizer.state == UIGestureRecognizerState.Ended {
            if (velocity.x >= 0) {
                openMenu()
            }
            else {
                closeMenu()
            }
        }
    }
    
    func onMenuSwipeClose(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        closeMenu()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didPressHamburger(sender: AnyObject) {
        if (self.mainView.frame.origin.x == self.openMenuOffset) {
            self.closeMenu()
        } else {
            self.openMenu()
        }
    }
    
    func openMenu() {
        self.scrollView.scrollEnabled = false
        UIView.animateWithDuration(0.6, animations: {
            self.mainView.frame.origin.x = self.openMenuOffset
        })
    }
    
    func closeMenu() {
        self.scrollView.scrollEnabled = true
        UIView.animateWithDuration(0.6, animations: {
            self.mainView.frame.origin.x = 0
        })
    }
}
