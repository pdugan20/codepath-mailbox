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
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageImageView: UIImageView!
    @IBOutlet weak var archiveIconImageView: UIImageView!
    @IBOutlet weak var laterIconImageView: UIImageView!
    
    let blueColor = UIColor(red: 68/255, green: 170/255, blue: 210/255, alpha: 1)
    let yellowColor = UIColor(red: 254/255, green: 202/255, blue: 22/255, alpha: 1)
    let brownColor = UIColor(red: 206/255, green: 150/255, blue: 98/255, alpha: 1)
    let greenColor = UIColor(red: 85/255, green: 213/255, blue: 80/255, alpha: 1)
    let redColor   = UIColor(red: 231/255, green: 61/255, blue: 14/255, alpha: 1)
    let grayColor = UIColor(red: 178/255, green: 178/255, blue: 178/255, alpha: 1)
    
    var openMenuOffset = CGFloat(300)
    var mainViewCenter = CGPoint()
    var messageCenter = CGPoint()
    var leftViewOrigin = CGPoint()
    var rightViewOrigin = CGPoint()
    
    var menuIsOpen: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: 320, height: 2240)
        
        self.mainViewCenter = self.mainView.center
        self.messageCenter = self.messageImageView.center
        
        self.messageView.backgroundColor = self.yellowColor
        
        var edgePanGestureLeft = UIScreenEdgePanGestureRecognizer(target: self, action: "onMenuSwipeOpen:")
        edgePanGestureLeft.edges = UIRectEdge.Left
        self.mainView.addGestureRecognizer(edgePanGestureLeft)
        
        var edgePanGestureRight = UIScreenEdgePanGestureRecognizer(target: self, action: "onMenuSwipeClose:")
        edgePanGestureRight.edges = UIRectEdge.Right
        self.mainView.addGestureRecognizer(edgePanGestureRight)
        
    }
    
    // Message pan gesture recgonizer
    @IBAction func didPanMessage(sender: UIPanGestureRecognizer) {
        var location = sender.locationInView(view)
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        
        self.messageImageView.center.x = location.x
    }
    
    // Left screen edge pan gesture recognizer
    func onMenuSwipeOpen(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        var translation = gestureRecognizer.translationInView(view)
        var velocity = gestureRecognizer.velocityInView(view)
        
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            // do nothing
        } else if gestureRecognizer.state == UIGestureRecognizerState.Changed {
            self.mainView.center.x = translation.x + mainViewCenter.x
        } else if gestureRecognizer.state == UIGestureRecognizerState.Ended {
            if (velocity.x >= 0) {
                openMenu()
            } else {
                closeMenu()
            }
        }
    }
    
    // Right screen edge pan gesture recognizer
    func onMenuSwipeClose(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        var translation = gestureRecognizer.translationInView(view)
        var velocity = gestureRecognizer.velocityInView(view)
        
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            // do nothing
        } else if gestureRecognizer.state == UIGestureRecognizerState.Changed {
            self.mainView.center.x = translation.x + (mainViewCenter.x + openMenuOffset)
        } else if gestureRecognizer.state == UIGestureRecognizerState.Ended {
            if (velocity.x >= 0) {
                openMenu()
            } else {
                closeMenu()
            }
        }
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
        UIView.animateWithDuration(0.6, animations: {
            self.menuIsOpen = true
            self.setNeedsStatusBarAppearanceUpdate()
            self.mainView.frame.origin.x = self.openMenuOffset
        })
    }
    
    // Closes hamburger menu
    func closeMenu() {
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