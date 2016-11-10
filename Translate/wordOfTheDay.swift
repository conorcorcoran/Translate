//
//  ViewController.swift
//  Translate
//
//  Created by Robert O'Connor on 16/10/2015.
//  Copyright © 2015 WIT. All rights reserved.
//

import UIKit


class wordOfTheDay: UIViewController
{
    @IBOutlet var wordText: UITextView!
    
    var wordsOfTheDay: [String: String] = ["Car":"Voiture", "Sleep":"Uyku", "Farm":"Feirme"]
    
       override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*func pickWord()
    {
        let ranNum = Int(arc4random_uniform(3))
        
        wordText.text = wordsOfTheDay[ranNum]
    }
 */
    
  }
