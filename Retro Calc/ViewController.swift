//
//  ViewController.swift
//  Retro Calc
//
//  Created by Raghav Vashisht on 07/04/17.
//  Copyright © 2017 Raghav Vashisht. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var outputLabl: UILabel!
    
    var btnSound: AVAudioPlayer!
    var runningNumber = ""
    var leftValString = ""
    var rightValString = ""
    var result = ""
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    
    override func viewDidLoad() {
        outputLabl.text = "0"
        super.viewDidLoad()
        let btn = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: btn!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    @IBAction func numberPressed (sender: UIButton) {
        playBtnSound()
        runningNumber += "\(sender.tag)"
        outputLabl.text = runningNumber
        
    }
    
    @IBAction func onDividePressed (sender: AnyObject) {
        playBtnSound()
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMultiplyPressed (sender: AnyObject) {
        playBtnSound()
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onSubtractPressed (sender: AnyObject) {
        playBtnSound()
        processOperation(operation: .Subtract)
    }
    
    @IBAction func onAddPressed (sender: AnyObject) {
        playBtnSound()
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualsPressed (sender: AnyObject) {
        playBtnSound()
        processOperation(operation: currentOperation)
    }
    
    @IBAction func onClearPressed(_ sender: Any) {
        playBtnSound()
        runningNumber = ""
        leftValString = ""
        rightValString = ""
        result = ""
        currentOperation = Operation.Empty
        outputLabl.text = "0"

        
    }
    func playBtnSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    
    func processOperation(operation: Operation) {
        if currentOperation != Operation.Empty {
            if runningNumber != "" {
                rightValString = runningNumber
                runningNumber = ""
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValString)! * Double(rightValString)!)"
                    
                    
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValString)! / Double(rightValString)!)"
                    
                    
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValString)! - Double(rightValString)!)"
                    
                    
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValString)! + Double(rightValString)!)"
                    
                    
                }
                leftValString = result
                outputLabl.text = result
            }
            
            currentOperation = operation
        } else {
            //This is the first time an Operation is Pressed
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
    
}

