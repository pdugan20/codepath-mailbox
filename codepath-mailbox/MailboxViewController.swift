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
    
    var menuIsOpen: Bool = false
    
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
    
    // Left screen edge pan gesture recognizer
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
    
    // Right screen edge pan gesture recognizer
    func onMenuSwipeClose(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        closeMenu()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Registers tap action for hamburger menu icon
    @IBAction func didPressHamburger(sender: AnyObject) {
        if (self.mainView.frame.origin.x == self.openMenuOffset) {
            self.closeMenu()
        } else {
            self.openMenu()
        }
    }
    
    // Opens hamburger menu
    func openMenu() {
        self.scrollView.scrollEnabled = false
        UIView.animateWithDuration(0.6, animations: {
            self.menuIsOpen = true
            self.setNeedsStatusBarAppearanceUpdate()
            self.mainView.frame.origin.x = self.openMenuOffset
        })
    }
    
    // Closes hamburger menu
    func closeMenu() {
        self.scrollView.scrollEnabled = true
        UIView.animateWithDuration(0.6, animations: {
            self.menuIsOpen = false
            self.setNeedsStatusBarAppearanceUpdate()
            self.mainView.frame.origin.x = 0
        })
    }
    
    // Sets status bar style to either light or dark (default)
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        if menuIsOpen {
            return UIStatusBarStyle.LightContent
        } else {
            return UIStatusBarStyle.Default
        }
    }
}
