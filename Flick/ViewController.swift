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
    
    @IBAction func login(_ sender: UIBarButtonItem) {
        svc = SFSafariViewController(url: Authentication.getLoginUrl() as URL)
        svc!.delegate = self
        self.present(svc!, animated: true, completion: nil)
    }
    
    @IBAction func refresh(_ sender: UIButton) {
        responseText.text = Page.Front.posts.first?.title
    }
    
    @IBOutlet weak var responseText: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Authentication.loginNoUser()
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.safariLogin(_:)), name: "userLoggedIn" as NSNotification.Name, object: nil)
    }
    
    func safariLogin(_ notification: Notification) {
        self.svc!.dismiss(animated: true, completion: nil)
        refreshDisplay()
    }
    
    func refreshDisplay() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: SFSafariViewControllerDelegate
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

