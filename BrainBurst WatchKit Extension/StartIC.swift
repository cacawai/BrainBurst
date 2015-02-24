//
//  StartIC.swift
//  BrainBurst
//
//  Created by xuxinyuan on 2/24/15.
//  Copyright (c) 2015 Last4. All rights reserved.
//

import WatchKit
import Foundation


class StartIC: WKInterfaceController {

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func onStartBtnClick() {
        NSLog("onStartBtnClick", self)
    }
    
    @IBAction func onRanksBtnClick() {
        WKInterfaceController.openParentApplication(["rank":"1"], reply: { (reply, error) -> Void in
            if ((error) != nil) {
                NSLog("error = %@", error)
            }
        })
    }
}
