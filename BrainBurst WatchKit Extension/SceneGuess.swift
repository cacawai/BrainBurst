//
//  SceneGuess.swift
//  BrainBurst
//
//  Created by xuxinyuan on 4/7/15.
//  Copyright (c) 2015 Last4. All rights reserved.
//

import WatchKit
import Foundation


class SceneGuess: WKInterfaceController {
    var resultNumber1:Int!
    var resultNumber2:Int!
    var resultNumber3:Int!
    var resultNumber4:Int!
    
    var currentNumber1:Int! = 0
    var currentNumber2:Int! = 0
    var currentNumber3:Int! = 0
    var currentNumber4:Int! = 0
    
    @IBOutlet weak var slider1: WKInterfaceSlider!
    @IBOutlet weak var slider2: WKInterfaceSlider!
    @IBOutlet weak var slider3: WKInterfaceSlider!
    @IBOutlet weak var slider4: WKInterfaceSlider!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        generateResultNumber()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func generateResultNumber() {
        resultNumber1 = Int(arc4random_uniform(10))
        resultNumber2 = Int(arc4random_uniform(10))
        resultNumber3 = Int(arc4random_uniform(10))
        resultNumber4 = Int(arc4random_uniform(10))
        checkAnswer()
        println("\(resultNumber1) \(resultNumber2) \(resultNumber3) \(resultNumber4)")
    }
    
    func checkAnswer() {
        var numA = 0
        var numB = 0
        if(resultNumber1 == currentNumber1){
            numA++
        }else{
            if(hasThisNum(currentNumber1)){
                numB++
            }
        }
        
        if(resultNumber2 == currentNumber2){
            numA++
        }else{
            if(hasThisNum(currentNumber2)){
                numB++
            }
        }
        
        if(resultNumber3 == currentNumber3){
            numA++
        }else{
            if(hasThisNum(currentNumber3)){
                numB++
            }
        }
        
        if(resultNumber4 == currentNumber4){
            numA++
        }else{
            if(hasThisNum(currentNumber4)){
                numB++
            }
        }
        self.setTitle("\(numA)A \(numB)B")
    }
    
    func hasThisNum(num: Int) ->Bool{
        if(num == resultNumber1
            || num == resultNumber2
            || num == resultNumber3
            || num == resultNumber4){
                return true
        }else{
            return false
        }
    }

    @IBAction func valueChanged1(value: Float) {
        currentNumber1 = Int(value)
    }
    
    @IBAction func valueChanged2(value: Float) {
        currentNumber2 = Int(value)
    }
    
    @IBAction func valueChanged3(value: Float) {
        currentNumber3 = Int(value)
    }
    
    @IBAction func valueChanged4(value: Float) {
        currentNumber4 = Int(value)
    }
    
    @IBAction func guess() {
        checkAnswer()
    }
}
