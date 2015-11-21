//
//  ViewController.swift
//  ZachGame1
//
//  Created by igor dvorkin on 11/20/15.
//  Copyright © 2015 igor dvorkin. All rights reserved.
//

import UIKit
import Neon
import RxCocoa
import Dollar

class Helpers{
    
    static func buttonForTitle(title:String)->UIButton
    {
        let button = UIButton ();
        button.setTitle(title,forState:.Normal)
        button.backgroundColor = UIColor.redColor()
        button.rx_tap.subscribeNext({ ViewController.displayButtonName(button)})
        return button
    }
    
}

class ViewController: UIViewController {

    let containerView:UIView = UIView()
    let main:UIButton = Helpers.buttonForTitle("Zach")
    static let letters = "a b  c d e f g h i j k l m n o p q r s t u v w x y z".componentsSeparatedByString(" ")
    static let countButtons=4
    let buttons = $.shuffle(letters.map(Helpers.buttonForTitle)).prefix(countButtons)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.clipsToBounds = true
        containerView.backgroundColor = UIColor.darkGrayColor()
        
        view.addSubview(containerView)
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(containerView)
        containerView.fillSuperview(left: 10, right: 10, top: 25, bottom: 100)
        containerView.addSubview(main)
        // main.fillSuperview(left: 10, right: 10, top: 25, bottom: 50)
        buttons.forEach{containerView.addSubview($0)}
        containerView.groupAndFill(group: .Horizontal, views: buttons.map{$0 as Frameable}, padding: 10)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
  static func displayButtonName(sender: UIButton!) {
        let alertView = UIAlertView();
        alertView.addButtonWithTitle("Ok");
        alertView.title = "You clicked button labeled:"
        alertView.message  = (sender?.titleLabel?.text)!;
        alertView.show();
    }
}

