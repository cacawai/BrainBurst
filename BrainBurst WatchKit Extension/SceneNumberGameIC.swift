//
//  SceneNumberGameIC.swift
//  BrainBurst
//
//  Created by xuxinyuan on 2/24/15.
//  Copyright (c) 2015 Last4. All rights reserved.
//

import WatchKit
import Foundation


class SceneNumberGameIC: WKInterfaceController {
    @IBOutlet weak var numLabel: WKInterfaceLabel!
    @IBOutlet weak var yesBtn: WKInterfaceButton!
    @IBOutlet weak var noBtn: WKInterfaceButton!
    
    let symbols = ["+","−","×"]
    var firstNumber = 0
    var secondNumber = 0
    var symbol = 0
    var correctResult = 0
    var displayResult = 0
    var timeCost:NSTimeInterval = 0
    var currentIndex = 0
    var correctAnswerCount = 0
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
        initAll()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        timeCost = NSDate().timeIntervalSince1970
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    func initAll()
    {
        correctAnswerCount = 0
        currentIndex = 0
        timeCost = NSDate().timeIntervalSince1970
        yesBtn.setTitle("YES")
        noBtn.setTitle("NO")
        self.setTitle("1/10")
        generateNumbers()
    }
    
    func generateRandomSymbolIndex()->Int
    {
        return Int(arc4random_uniform(3))
    }
    
    func generateNumbers()
    {
        let yesOrNo = Int(arc4random_uniform(2))
        let randomSymbolIndex = generateRandomSymbolIndex()
        firstNumber = Int(arc4random_uniform(10))
        secondNumber = Int(arc4random_uniform(10))
        correctResult = generateAnswer(randomSymbolIndex)
        if(yesOrNo == 1 || correctResult==0){
            displayResult = correctResult + Int(arc4random_uniform(2))
        }else{
            displayResult = correctResult - Int(arc4random_uniform(2))
        }
        
        let finalString:String? = "\(firstNumber)\(symbols[randomSymbolIndex])\(secondNumber)=\(displayResult)"
        numLabel.setText(finalString)
    }
    
    func generateAnswer(symbolIndex:Int)->Int
    {
        switch symbolIndex
        {
        case 1:
            if(firstNumber > secondNumber){
                return firstNumber-secondNumber
            }else{
                return secondNumber-firstNumber
            }
        case 2:
            return firstNumber*secondNumber
        default:
            return firstNumber+secondNumber
        }
    }
    
    func checkAnswer(isYes:Bool)
    {
        if(((correctResult == displayResult) && isYes)
            || ((correctResult != displayResult) && !isYes)){
            correctAnswerCount++
            self.setTitle("\(currentIndex+1)/10 Correct!")
        }else{
            self.setTitle("\(currentIndex+1)/10 Wrong!")
        }
        currentIndex++;
        if(currentIndex >= 10){
            timeCost = NSDate().timeIntervalSince1970 - timeCost
            let timeCostString = String(format: "%.3f", timeCost)
            numLabel.setText("\(correctAnswerCount)/10 Correct!\nCost \(timeCostString)s")
            yesBtn.setTitle("Again")
            noBtn.setTitle("Exit")
        }else{
            generateNumbers()
        }
    }
    
    @IBAction func onYesBtnClick() {
        if(currentIndex >= 10){
            initAll()
        }else{
            checkAnswer(true)
        }
    }
    
    @IBAction func onNoBtnClick() {
        if(currentIndex >= 10){
            initAll()
            self.dismissController()
        }else{
            checkAnswer(false)
        }
    }
}
