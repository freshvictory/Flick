//
//  ViewController.swift
//  Flick
//
//  Created by Justin Renjilian on 7/26/16.
//  Copyright © 2016 Justin Renjilian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func logIn(sender: UIButton) {
        Authentication.login(false)
        responseText.text = Authentication.responseText
    }
    @IBOutlet weak var responseText: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

