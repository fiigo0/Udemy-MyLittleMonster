//
//  ViewController.swift
//  myLittleMonster
//
//  Created by Diaz Orona, Jesus A. on 3/31/16.
//  Copyright © 2016 Diaz Orona, Jesus A. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var monsterImg: MonsterImg!
    @IBOutlet weak var foodImg:DragImage!
    @IBOutlet weak var heartImg:DragImage!
    @IBOutlet weak var skull1Img: UIImageView!
    @IBOutlet weak var skull2Img: UIImageView!
    @IBOutlet weak var skull3Img: UIImageView!
    
    let DIM_ALPHA:CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    let MAX_PENALTIES = 3
    let FOOD:UInt32 = 1
    let HEART:UInt32 = 0
    
    var penalties = 0
    var isMonsterHappy:Bool = false
    var currentItem:UInt32 = 0
    
    var timer:NSTimer!
    
    var musicPlayer:AVAudioPlayer!
    var sfxBite:AVAudioPlayer!
    var sfxHeart:AVAudioPlayer!
    var sfxDeath:AVAudioPlayer!
    var sfxSkull:AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodImg.dropTarget = monsterImg
        heartImg.dropTarget = monsterImg
        
        skull1Img.alpha = DIM_ALPHA
        skull2Img.alpha = DIM_ALPHA
        skull3Img.alpha = DIM_ALPHA
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name: "onTargetDropped", object: nil)
        
        do{
            try musicPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!))
            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
            try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))
            
            musicPlayer.prepareToPlay()
            musicPlayer.play()
            
            sfxBite.prepareToPlay()
            sfxDeath.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxSkull.prepareToPlay()

            
        } catch let err as NSError {
            print(err.description)
        }

        startTimmer()
    }
    
    func itemDroppedOnCharacter(notif:AnyObject){
        isMonsterHappy = true
        startTimmer()
        foodImg.alpha = DIM_ALPHA
        heartImg.alpha = DIM_ALPHA
        foodImg.userInteractionEnabled = false
        heartImg.userInteractionEnabled = false
        
        if currentItem == FOOD {
            sfxBite.play()
        }else {
            sfxHeart.play()
        }
    }
    
    func startTimmer(){
    
        if timer != nil {
            timer.invalidate()
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
        
    }
    
    func changeGameState(){

        if !isMonsterHappy {
            penalties++
            sfxSkull.play()
            if penalties == 1 {
                skull1Img.alpha = OPAQUE
            }else if penalties == 2 {
                skull2Img.alpha = OPAQUE
            }else if penalties >= 3 {
                skull3Img.alpha = OPAQUE
            }else {
                skull1Img.alpha = DIM_ALPHA
                skull2Img.alpha = DIM_ALPHA
                skull3Img.alpha = DIM_ALPHA
            }
            
            if penalties == MAX_PENALTIES {
                gameOver()
            }
        }
        
       let rand = arc4random_uniform(2)
        
        if rand == HEART {
            foodImg.alpha = DIM_ALPHA
            foodImg.userInteractionEnabled = false
            
            heartImg.alpha = OPAQUE
            heartImg.userInteractionEnabled = true
        }else {
            foodImg.alpha = OPAQUE
            foodImg.userInteractionEnabled = true
            
            heartImg.alpha = DIM_ALPHA
            heartImg.userInteractionEnabled = false
        }
        
        currentItem = rand
        isMonsterHappy = false
    }
    
    func gameOver(){
        timer.invalidate()
        monsterImg.playDeathAnimation()
        sfxDeath.play()
    }
    
}

