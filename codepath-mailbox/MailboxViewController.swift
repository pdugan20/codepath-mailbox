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
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var listImageView: UIImageView!
    @IBOutlet weak var rescheduleImageView: UIImageView!
    
    let blueColor = UIColor(red: 68/255, green: 170/255, blue: 210/255, alpha: 1)
    let yellowColor = UIColor(red: 254/255, green: 202/255, blue: 22/255, alpha: 1)
    let brownColor = UIColor(red: 206/255, green: 150/255, blue: 98/255, alpha: 1)
    let greenColor = UIColor(red: 85/255, green: 213/255, blue: 80/255, alpha: 1)
    let redColor   = UIColor(red: 231/255, green: 61/255, blue: 14/255, alpha: 1)
    let grayColor = UIColor.lightGrayColor()
    
    var openMenuOffset = CGFloat(300)
    var mainViewCenter = CGPoint()
    var messageCenter = CGPoint()
    var leftViewOrigin = CGPoint()
    var rightViewOrigin = CGPoint()
    
    var gestureViewStartingOrigin: CGPoint!
    var messageViewStartingOrigin: CGPoint!
    var laterIconStartingOrigin: CGPoint!
    var archiveIconStartingOrigin: CGPoint!
    
    var scrollViewHeight = 2240
    var menuIsOpen: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the scrollView content size
        scrollView.contentSize = CGSize(width: 320, height: scrollViewHeight)
        
        // Store center coordinates for views
        self.mainViewCenter = self.mainView.center
        self.messageCenter = self.messageImageView.center
        
        // Hide icons and full-screen images on initial view load
        laterIconImageView.alpha = 0
        archiveIconImageView.alpha = 0
        listImageView.alpha = 0
        rescheduleImageView.alpha = 0
        
        // Initially set messageView background color to yellow
        self.messageView.backgroundColor = self.grayColor
        
        // Instantiate menu open gesture
        var edgePanGestureLeft = UIScreenEdgePanGestureRecognizer(target: self, action: "onMenuSwipeOpen:")
        edgePanGestureLeft.edges = UIRectEdge.Left
        self.mainView.addGestureRecognizer(edgePanGestureLeft)
        
        // Instantiate menu close gesture
        var edgePanGestureRight = UIScreenEdgePanGestureRecognizer(target: self, action: "onMenuSwipeClose:")
        edgePanGestureRight.edges = UIRectEdge.Right
        self.mainView.addGestureRecognizer(edgePanGestureRight)
        
    }
    
    // Message pan gesture recgonizer
    @IBAction func didPanMessage(sender: UIPanGestureRecognizer) {
        var location = sender.locationInView(view)
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            gestureViewStartingOrigin = location
            messageViewStartingOrigin = messageImageView.frame.origin
            laterIconStartingOrigin = laterIconImageView.frame.origin
            archiveIconStartingOrigin = archiveIconImageView.frame.origin
            
            messageView.backgroundColor = grayColor
            laterIconImageView.image = UIImage(named: "later_icon")
            archiveIconImageView.image = UIImage(named: "archive_icon")
        
        // Control dragable messageView on x-axis
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            var currentOrigin = messageViewStartingOrigin.x + location.x - 
                gestureViewStartingOrigin.x
                messageImageView.frame.origin.x = currentOrigin
            
            // Swipe left inside of messageView
            if currentOrigin < 0 {
                
                // Later icon + gray background
                if -60 < currentOrigin {
                    self.laterIconImageView.alpha = translation.x/(60 * -1)
                    self.messageView.backgroundColor = self.grayColor
                
                // Later icon + yellow background
                } else if (-260 <= currentOrigin) && (currentOrigin < -60) {
                    self.laterIconImageView.alpha = 1
                    self.laterIconImageView.frame.origin.x = self.laterIconStartingOrigin.x + 
                        location.x - self.gestureViewStartingOrigin.x + 60
                    
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.messageView.backgroundColor = self.yellowColor
                        self.laterIconImageView.image = UIImage(named: "later_icon")
                    })
                
                // List icon + brown background
                } else if currentOrigin < -260 {
                    self.laterIconImageView.alpha = 1
                    self.laterIconImageView.frame.origin.x = self.laterIconStartingOrigin.x + 
                        location.x - self.gestureViewStartingOrigin.x + 60
                    
                    UIView.animateWithDuration(0.3, animations: {  () -> Void in
                        self.messageView.backgroundColor = self.brownColor
                        self.laterIconImageView.image = UIImage(named: "list_icon")
                    })
                }
            
            // Swipe right inside of messageView
            } else if 0 < currentOrigin {
                
                // Archive icon + gray background
                if currentOrigin < 60 {
                    self.archiveIconImageView.frame.origin.x = 16
                    self.archiveIconImageView.alpha = translation.x/60
                    self.messageView.backgroundColor = self.grayColor
                
                // Archive icon + green background    
                } else if (60 < currentOrigin) && (currentOrigin <= 260) {
                    self.archiveIconImageView.alpha = 1
                    self.archiveIconImageView.frame.origin.x = self.archiveIconStartingOrigin.x +
                        location.x - self.gestureViewStartingOrigin.x - 60
                    
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.messageView.backgroundColor = self.greenColor
                        self.archiveIconImageView.image = UIImage(named: "archive_icon")
                    })
                
                // Delete icon + green background  
                } else if 260 < currentOrigin {
                    self.archiveIconImageView.alpha = 1
                    self.archiveIconImageView.frame.origin.x = self.archiveIconStartingOrigin.x +
                        location.x - self.gestureViewStartingOrigin.x - 60
                    
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.messageView.backgroundColor = self.redColor
                        self.archiveIconImageView.image = UIImage(named: "delete_icon")
                    })
                }
            }
        
        // Handle animations post-drag of messageView
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            // Swipe left inside of messageView
            if translation.x < 0 {
                
                // Snap back to original origin
                if -60 < translation.x {
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.messageImageView.frame.origin.x = self.messageViewStartingOrigin.x
                        self.laterIconImageView.frame.origin.x = self.laterIconStartingOrigin.x
                        self.laterIconImageView.alpha = 0
                        self.messageView.backgroundColor = self.grayColor
                    })
                }
                
                // Complete animation (yellow background + later icon)
                else if (-260 <= translation.x) && (translation.x < -60) {
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.messageImageView.frame.origin.x = -320
                        self.laterIconImageView.alpha = 0
                        self.messageView.backgroundColor = self.yellowColor
                    
                    // Show options imageView
                    }, completion: { (BOOL) -> Void in
                        UIView.animateWithDuration(0.3, animations: { () -> Void in
                            self.rescheduleImageView.alpha = 1
                        })
                    })
                
                // Complete animation (brown background + list icon)
                } else {
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.messageImageView.frame.origin.x = -320
                        self.laterIconImageView.alpha = 0
                        self.messageView.backgroundColor = self.brownColor
                        
                        // Show options imageView
                        }, completion: { (BOOL) -> Void in
                            UIView.animateWithDuration(0.3, animations: { () -> Void in
                                self.listImageView.alpha = 1
                        })
                    })
                }
                
            // Swipe right inside of the messageView
            } else if 0 < translation.x {
                
                // Snap back to original origin
                if translation.x < 60 {
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.messageImageView.frame.origin.x = self.messageViewStartingOrigin.x
                        self.archiveIconImageView.frame.origin.x = self.archiveIconStartingOrigin.x
                        self.archiveIconImageView.alpha = 0
                        self.messageView.backgroundColor = self.grayColor
                    })
                
                // Complete animation (green background + archive icon)
                } else if (60 < translation.x) && (translation.x <= 260) {
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.messageImageView.frame.origin.x = 320
                        self.archiveIconImageView.alpha = 0
                        self.messageView.backgroundColor = self.greenColor
                    
                    // Hide the messageView
                    }, completion: { (BOOL) -> Void in
                        self.hideMessageView()
                    })
                
                // Complete animation (red background + delete icon)
                } else {
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.messageImageView.frame.origin.x = 320
                        self.archiveIconImageView.alpha = 0
                        self.messageView.backgroundColor = self.redColor
                    
                    // Hide the messageView
                    }, completion: { (BOOL) -> Void in
                        self.hideMessageView()
                    })
                }
            }
        }
    }
    
    // Hides messageView after some user action
    func hideMessageView() {
        messageView.backgroundColor = UIColor(white: 1, alpha: 0)
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.feedImageView.frame.origin.y -= 86
            }, completion:
            { (BOOL) -> Void in
                self.messageImageView.frame.origin.x = 0
                self.laterIconImageView.frame.origin.x = 279
                self.laterIconImageView.image = UIImage(named: "later_icon")
                self.laterIconImageView.alpha = 0
                self.archiveIconImageView.frame.origin.x = 16
                self.archiveIconImageView.image = UIImage(named: "archive_icon")
                self.archiveIconImageView.alpha = 0
                self.messageView.backgroundColor = self.grayColor
        })
        
        // Update scrollView height
        self.scrollViewHeight -= 86
        scrollView.contentSize = CGSize(width: 320, height: scrollViewHeight)
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
    
    // Tap gesture recgonizer that hides ListImageView
    @IBAction func didTapListImageView(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.listImageView.alpha = 0
            }, completion: { (BOOL) -> Void in
            self.hideMessageView()
        })
    }
    
    // Tap gesture recgonizer that hides RescheduleImageView
    @IBAction func didTapRescheduleImageView(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.rescheduleImageView.alpha = 0
            }, completion: { (BOOL) -> Void in
                self.hideMessageView()
        })
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