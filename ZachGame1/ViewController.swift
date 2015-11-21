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
import AVFoundation
/// TODO: TTS - http://www.appcoda.com/text-to-speech-ios-tutorial/

class Helpers{
    
    static func buttonForTitle(title:String)->UIButton
    {
        let button = UIButton ();
        button.titleLabel?.font = UIFont.systemFontOfSize(50)
        button.setTitle(title,forState:.Normal)
        button.backgroundColor = UIColor.redColor()
        button.rx_tap.subscribeNext({ ViewController.displayButtonName(button)})
        return button
    }
    
}

class ViewController: UIViewController {

    let containerView:UIView = UIView()
    let main:UIButton = Helpers.buttonForTitle("Zach")
    static let letters = "a b c d e f g h i j k l m n o p q r s t u v w x y z".componentsSeparatedByString(" ")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.clipsToBounds = true
        containerView.backgroundColor = UIColor.darkGrayColor()
        let countButtons=4
        let buttons = $.shuffle(ViewController.letters.map(Helpers.buttonForTitle)).prefix(countButtons)
        
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
        let title = (sender?.titleLabel?.text)!;
    /*
        let alertView = UIAlertView();
        alertView.addButtonWithTitle("Ok");
        alertView.title = "You clicked button labeled:"
        alertView.message  = title
        alertView.show();
    */
        let synth = AVSpeechSynthesizer()
        let myUtterance = AVSpeechUtterance(string:title)
        synth.speakUtterance(myUtterance)
    }
}

