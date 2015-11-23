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

    var currentContainerView:UIView = UIView()
    let main:UIButton = Helpers.buttonForTitle("Zach")
    static let sightWords = "on;for;at;and;of;I;me;him;her;who;how;cat;dog;cow".componentsSeparatedByString(";")
    static let letters = "a b c d e f g h i j k l m n o p q r s t u v w x y z".componentsSeparatedByString(" ")
    
    func CreateView(parentView:UIView)-> UIView
    {
        let newContainerView = UIView()
        parentView.addSubview(newContainerView)
        newContainerView.clipsToBounds = true
        newContainerView .backgroundColor = UIColor.darkGrayColor()
        newContainerView.fillSuperview()
        
        let randomSightWord = $.shuffle(ViewController.sightWords).first!
        
        // Add top level rows
        let topHalf = UIView()
        let bottomHalf = UIView()
        let reloadHalf = UIView()
        let topLevelRows = [topHalf, bottomHalf, reloadHalf]
        topLevelRows.forEach(newContainerView.addSubview)
        newContainerView.groupAndFill(group: .Vertical, views:topLevelRows.map {$0 as Frameable}, padding: 10)
        
        // Put sightWord in bottom half
        let sightWord = Helpers.buttonForTitle(randomSightWord)
        bottomHalf.addSubview(sightWord)
        sightWord.fillSuperview(left:10, right:10, top:10, bottom:10)
        
        // Put sightWord letters in the top half.
        let letters = Array(randomSightWord.characters).map {String.init($0)}
        let buttons = letters.map(Helpers.buttonForTitle)
        buttons.forEach{topHalf.addSubview($0)}
        topHalf.groupAndFill(group: .Horizontal, views: buttons.map {$0 as Frameable}, padding: 10)
        
        // Add a reload button
        let reloadButton = UIButton()
        reloadButton.setTitle("reload",forState:.Normal)
        reloadButton.backgroundColor = UIColor.redColor()
        reloadButton.titleLabel?.font = UIFont.systemFontOfSize(30)
        reloadHalf.addSubview(reloadButton)
        reloadButton.fillSuperview()
        reloadButton.rx_tap.subscribeNext{
            self.currentContainerView.removeFromSuperview();
            self.currentContainerView = self.CreateView(self.view)
        }
        return newContainerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentContainerView = CreateView(view)
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

