//
//  File.swift
//  Concentration
//
//  Created by Samuel Germain on 2019-10-22.
//  Copyright © 2019 Sam G. All rights reserved.
//

import Foundation

class FlipCount: NSObject{
    var value = 0
    
    func increment(){
        value += 1
    }
    
    func reset(){
        value = 0
    }
    
}
