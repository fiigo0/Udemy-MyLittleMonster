//
//  MonsterImg.swift
//  myLittleMonster
//
//  Created by Diaz Orona, Jesus A. on 4/1/16.
//  Copyright © 2016 Diaz Orona, Jesus A. All rights reserved.
//

import Foundation
import UIKit

class MonsterImg: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        playIdleAnimation()
    }
    
    func playIdleAnimation(){
        
        self.image = UIImage(named: "idle1.png")
        self.animationImages = nil
        
        var imageArray=[UIImage]()
        
        for var x = 1; x <= 4; x++ {
            
            let img = UIImage(named: "idle\(x).png")
            imageArray.append(img!)
        }
        
        self.animationImages = imageArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 0
        self.startAnimating()
        
    }
    
    func playDeathAnimation(){
        self.image = UIImage(named: "dead5.png")
        self.animationImages = nil
        
        var imageArray=[UIImage]()
        
        for var x = 1; x <= 5; x++ {
            let img = UIImage(named: "dead\(x).png")
            imageArray.append(img!)
        }
        
        self.animationImages = imageArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1
        self.startAnimating()
    }
    
    
    func playRestartAnimation(){
        self.image = UIImage(named: "dead1.png")
        self.animationImages = nil
        
        var imageArray=[UIImage]()
        
        for var x = 5; x >= 1; x-- {
            let img = UIImage(named: "dead\(x).png")
            imageArray.append(img!)
        }
        
        self.animationImages = imageArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1
        self.startAnimating()

    
    }
    
}
