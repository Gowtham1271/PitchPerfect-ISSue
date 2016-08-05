//
//  PlaysounsViewController.swift
//  PitchPerfectApp
//
//  Created by Datasisar on 8/3/16.
//  Copyright © 2016 Datasisar. All rights reserved.
//

import UIKit
import AVFoundation

class PlaysoundsViewController: UIViewController {
    var recordedAudioURL : NSURL!
    
    
    @IBOutlet weak var snailbutton:UIButton!
    @IBOutlet weak var chipmunkbutton:UIButton!
    @IBOutlet weak var rabbitbutton:UIButton!
    @IBOutlet weak var vaderbutton:UIButton!
    @IBOutlet weak var echobutton:UIButton!
    @IBOutlet weak var reverbbutton:UIButton!
    @IBOutlet weak var stopbutton:UIButton!
   
    var recordedAudioURl: NSURL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode:AVAudioPlayerNode!
    var stopTimer: NSTimer!
    
  enum ButtonType: Int { case slow = 0,Fast, Chipmunk, Vader, Echo, Reverb}
    
    @IBAction func playsoundForButton(sender:UIButton){
        
        print("Play Sound Button Pressed")
        switch (ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .Fast:
            playSound(rate: 1.5)
        case .Chipmunk:
                playSound(pitch: 1000)
        case .Vader:
            playSound(pitch: -1000)
        default: break  }
       
        configureUI(.Playing)
    }
    @IBAction func StopButtonPressed(sender:AnyObject){
        print("Stop audio Button pressed")
        stopAudio()
        
    }
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("PlaysoundsViewController loaded")
        setupAudio()

        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        configureUI(.NotPlaying)
      
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    
}