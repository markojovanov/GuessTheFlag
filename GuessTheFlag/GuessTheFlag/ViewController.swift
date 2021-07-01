//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Finki User on 1.7.21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var flag1: UIButton!
    @IBOutlet var flag2: UIButton!
    @IBOutlet var flag3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        flag1.layer.borderWidth = 1.0
        flag2.layer.borderWidth = 1.0
        flag3.layer.borderWidth = 1.0

        flag1.layer.borderColor = UIColor.lightGray.cgColor
        flag2.layer.borderColor = UIColor.lightGray.cgColor
        flag3.layer.borderColor = UIColor.lightGray.cgColor

        askQuestion()
        
    }
    func askQuestion(){
        countries.shuffle()
        correctAnswer=Int.random(in: 0...2)
        title=countries[correctAnswer].uppercased()
        flag1.setImage(UIImage(named: countries[0]), for: .normal)
        flag2.setImage(UIImage(named: countries[1]), for: .normal)
        flag3.setImage(UIImage(named: countries[2]), for: .normal)
    }


}

