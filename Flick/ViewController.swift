//
//  ViewController.swift
//  Flick
//
//  Created by Justin Renjilian on 7/26/16.
//  Copyright © 2016 Justin Renjilian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var sr: Subreddit?
    var u: User?
    var p: Page?
    
    @IBAction func logIn(sender: UIButton) {
        sr = Subreddit(name: "news")
        u = User(username: "freshvictory")
        p = Page(subreddit: sr!)
        
    }
    @IBAction func refresh(sender: UIButton) {
        responseText.text = p?.posts.first?.title
    }
    @IBOutlet weak var responseText: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Authentication.login(false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

