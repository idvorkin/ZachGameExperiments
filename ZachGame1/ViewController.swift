//
//  ViewController.swift
//  ZachGame1
//
//  Created by igor dvorkin on 11/20/15.
//  Copyright © 2015 igor dvorkin. All rights reserved.
//

import UIKit
import Neon



/// TODO: TTS - http://www.appcoda.com/text-to-speech-ios-tutorial/
class ViewController: UIViewController {

    let main:UIButton = UIButton()
    let containerView:UIView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.clipsToBounds = true
        containerView.backgroundColor = UIColor(red: 61/255.0, green: 61/255.0, blue: 61/255.0, alpha: 1.0)
        
        view.addSubview(containerView)
        // Do any additional setup after loading the view, typically from a nib.
        main.setTitle("Zach", forState: .Normal)
        view.addSubview(containerView)
        containerView.fillSuperview(left: 10, right: 10, top: 25, bottom: 10)
        containerView.addSubview(main)
        main.fillSuperview(left: 10, right: 10, top: 25, bottom: 10)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

