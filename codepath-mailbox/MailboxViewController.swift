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
    
    let openMenuOffset = CGFloat(300)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.contentSize = CGSize(width: 320, height: 2240)
        
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
        UIView.animateWithDuration(0.4, animations: {
            self.mainView.frame.origin.x = self.openMenuOffset
        })
    }
    
    func closeMenu() {
        self.scrollView.scrollEnabled = true
        UIView.animateWithDuration(0.4, animations: {
            self.mainView.frame.origin.x = 0
        })
    }
}
