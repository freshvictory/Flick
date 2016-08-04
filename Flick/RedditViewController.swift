//
//  ViewController.swift
//  Flick
//
//  Created by Justin Renjilian on 7/26/16.
//  Copyright © 2016 Justin Renjilian. All rights reserved.
//

import UIKit
import SafariServices

class RedditViewController: UIViewController, SFSafariViewControllerDelegate, UIGestureRecognizerDelegate {
    
    var sr: Subreddit?
    var u: User?
    var p: Page?
    
    var svc: SFSafariViewController?
    
    @IBOutlet var panRec: UIPanGestureRecognizer!
    
    var swipeRec = UISwipeGestureRecognizer()
//    let panRec = UIPanGestureRecognizer()
    
    @IBAction func loginUser(sender: UIButton) {
        svc = SFSafariViewController(URL: Authentication.getLoginUrl())
        svc!.delegate = self
        self.presentViewController(svc!, animated: true, completion: nil)
    }
    
    @IBAction func refresh(sender: UIButton) {
        responseText.text = Page.Front.posts.first?.title
    }
    
    @IBOutlet weak var responseText: UITextView!
    
    @IBOutlet weak var topImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Gesture Recognizers
        panRec.addTarget(self, action: #selector(RedditViewController.draggedView))
        view.userInteractionEnabled = true
        view.addGestureRecognizer(panRec)
        view.addGestureRecognizer(swipeRec)
        panRec.delegate = self
        
        // Authenticate default user
        Authentication.loginNoUser()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RedditViewController.safariLogin(_:)), name: "userLoggedIn", object: nil)
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
    
    // MARK: Gestures
    var performGestures: Bool = true
    
    func draggedView(sender: UIPanGestureRecognizer) {
        let translation = sender.velocityInView(self.view)
        print("dragged: \(translation)")
        performGestures = Vector.vertical(translation)
        if performGestures {
            sender.view?.center = CGPointMake(sender.view!.center.x, sender.view!.center.y + translation.y)
            sender.setTranslation(CGPointZero, inView: self.view)
        }
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        if let gr = gestureRecognizer as? UIPanGestureRecognizer {
            let translation = gr.velocityInView(self.view)
            print("gesture: \(translation)")
            if translation != CGPointZero {
                performGestures = Vector.vertical(translation)
            }
        }
        return performGestures
    }

    // MARK: SFSafariViewControllerDelegate
    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}

