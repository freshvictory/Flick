//
//  ViewController.swift
//  Flick
//
//  Created by Justin Renjilian on 7/26/16.
//  Copyright © 2016 Justin Renjilian. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController, SFSafariViewControllerDelegate {
    
    var sr: Subreddit?
    var u: User?
    var p: Page?
    
    var svc: SFSafariViewController?
    
    @IBAction func login(sender: UIBarButtonItem) {
        svc = SFSafariViewController(URL: Authentication.getLoginUrl())
        svc!.delegate = self
        self.presentViewController(svc!, animated: true, completion: nil)
    }
    
    @IBAction func refresh(sender: UIButton) {
        responseText.text = Page.Front.posts.first?.title
    }
    
    @IBOutlet weak var responseText: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Authentication.loginNoUser()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.safariLogin(_:)), name: "userLoggedIn", object: nil)
    }
    
    func safariLogin(notification: NSNotification) {
        self.svc!.dismissViewControllerAnimated(true, completion: nil)
        refreshDisplay()
    }
    
    func refreshDisplay() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: SFSafariViewControllerDelegate
    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}

