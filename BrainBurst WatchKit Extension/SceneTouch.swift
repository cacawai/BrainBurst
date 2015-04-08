//
//  SceneTouch.swift
//  BrainBurst
//
//  Created by xuxinyuan on 3/29/15.
//  Copyright (c) 2015 Last4. All rights reserved.
//

import WatchKit
import Foundation


class SceneTouch: WKInterfaceController {
    @IBOutlet weak var tapBtn: WKInterfaceButton!
    var currentDate: NSDate?
    var timer: NSTimer?
    var isWaitingForTap: Bool! = false
    var isCounting: Bool = false {
        willSet(newValue) {
            if newValue {
                tapBtn.setTitle("Ready")
                var sec = Double(arc4random_uniform(30))/10.0
                timer = NSTimer.scheduledTimerWithTimeInterval(sec, target: self, selector: "updateTimer:", userInfo: nil, repeats: false)
            } else {
                timer?.invalidate()
                timer = nil
                currentDate = nil
            }
        }
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        isCounting = true
//        var sec = Double(arc4random_uniform(30))/10.0
//        delay(sec) {
//            self.tapBtn.setTitle("Tap!")
//            self.currentDate = NSDate()
//        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func onTouched() {
        NSLog("onTouched", self)
        if(isCounting==true && !isWaitingForTap){
            self.tapBtn.setTitle("Tap too early!")
            isCounting = false
            return
        }else if(!isWaitingForTap){
            isCounting = true
            return
        }
        var timeCost:NSTimeInterval = NSDate().timeIntervalSinceDate(currentDate!)
        var timeCostString = String(format: "%.3f", timeCost)
        self.tapBtn.setTitle("\(timeCostString)s")
        isWaitingForTap = false
        currentDate = nil
        isCounting = false
    }
    
    func updateTimer(timer: NSTimer) {
        println("Tap!")
        self.tapBtn.setTitle("Tap!")
        currentDate = NSDate()
        isWaitingForTap = true
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
}
