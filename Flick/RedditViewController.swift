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
    
    @IBAction func loginUser(_ sender: UIButton) {
        svc = SFSafariViewController(url: Authentication.getLoginUrl() as URL)
        svc!.delegate = self
        self.present(svc!, animated: true, completion: nil)
    }
    
    @IBAction func refresh(_ sender: UIButton) {
        responseText.text = Page.Front.posts.first?.title
    }
    
    @IBOutlet weak var responseText: UITextView!
    
    @IBOutlet weak var topImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Gesture Recognizers
        panRec.addTarget(self, action: #selector(RedditViewController.draggedView))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(panRec)
        view.addGestureRecognizer(swipeRec)
        panRec.delegate = self
        
        // Authenticate default user
        Authentication.loginNoUser()
        NotificationCenter.default.addObserver(self, selector: #selector(RedditViewController.safariLogin(_:)), name: "userLoggedIn" as NSNotification.Name, object: nil)
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
    
    // MARK: Gestures
    var performGestures: Bool = true
    
    func draggedView(_ sender: UIPanGestureRecognizer) {
        let translation = sender.velocity(in: self.view)
        print("dragged: \(translation)")
        performGestures = Vector.vertical(translation)
        if performGestures {
            sender.view?.center = CGPoint(x: sender.view!.center.x, y: sender.view!.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: self.view)
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let gr = gestureRecognizer as? UIPanGestureRecognizer {
            let translation = gr.velocity(in: self.view)
            print("gesture: \(translation)")
            if translation != CGPoint.zero {
                performGestures = Vector.vertical(translation)
            }
        }
        return performGestures
    }

    // MARK: SFSafariViewControllerDelegate
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

