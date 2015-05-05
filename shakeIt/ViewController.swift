//
//  ViewController.swift
//  shakeIt
//
//  Created by uyanga on 5/4/15.
//  Copyright (c) 2015 uyanga. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation

class ViewController: UIViewController {
    
    var song_intro = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("shack", ofType: "mp3")!)
//    var song = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("russ", ofType: "mp3")!)
    var songAudio = AVAudioPlayer()
    var songAudio2 = AVAudioPlayer()
    
    @IBOutlet weak var score: UILabel!
    
    var motionManager = CMMotionManager()
    
    override func viewDidLoad() {
//        songAudio = AVAudioPlayer(contentsOfURL: song, error: nil)
        songAudio2 = AVAudioPlayer(contentsOfURL: song_intro, error: nil)
//        songAudio.prepareToPlay()
        songAudio2.prepareToPlay()
        
        motionManager.accelerometerUpdateInterval = 0.0001
        
        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler: { (accelerometerData: CMAccelerometerData!, error:NSError!) -> Void in self.outputAccelerationData(accelerometerData.acceleration)
            if (error != nil) {
                println("\(error)")
            }
        })
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
//    var startTime = NSTimeInterval()
//    var seconds: UInt8?
//    func updateTime() {
//        var currentTime = NSDate.timeIntervalSinceReferenceDate()
//        var elapsedTime: NSTimeInterval = currentTime - startTime
//        seconds = UInt8(elapsedTime)
//    }
//    var timer = NSTimer()
//    @IBAction func startgame(sender: UIButton) {
//        if !timer.valid {
//            let aSelector : Selector = "updateTime"
//            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
//            startTime = NSDate.timeIntervalSinceReferenceDate()
//        }
//    }
    var score_game = 0
    var count = 0
    var array = Array<Double>()
    func outputAccelerationData(acceleration: CMAcceleration) {
        if count < 1500 {
            score.text = "\(score_game/2)"
            count++
            if array.count >= 1 {
                array.append(acceleration.y*1000)
                 println("\(array) working")
                if (array[0] < 0 && array[1] > 0) || (array[0] > 0 && array[1] < 0) {
                    score_game++
                    println("\(score_game) This is the score")
                }
                array.removeAtIndex(0)
                println("\(array) CHECKIGN IF GREATER")
            } else {
                array.append(acceleration.y*1000)
                println("\(array) SECOND ONE")
            }
                println("FINAL SCORE: \(score_game/2)")
        } else {
            score.text = "Your final score is \(score_game/2)"
//            songAudio.play()
            songAudio2.play()
//            timer.invalidate()
        }
    }
}

