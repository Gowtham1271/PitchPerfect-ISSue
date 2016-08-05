//
//  ViewController.swift
//  PitchPerfectApp
//
//  Created by Datasisar on 8/1/16.
//  Copyright © 2016 Datasisar. All rights reserved.
//

import UIKit
import AVFoundation
class recordsoundviewcontroller: UIViewController,AVAudioRecorderDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()	
        StopRecord.enabled=false
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var recordbutton: UIButton!
    @IBOutlet weak var StopRecord: UIButton!
    
    var audioRecorder : AVAudioRecorder!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func RecordAudio(sender: AnyObject) {
        print("Record button pressed")
    recordLabel.text = "recording in Progress"
    StopRecord.enabled=true
    recordbutton.enabled=false
        let dirpath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0]as String
        let recordingName = "recordedvoice.wav"
        let pathArray = [dirpath, recordingName]
        let filepath = NSURL.fileURLWithPathComponents(pathArray)
        print(filepath)
        let session = AVAudioSession.sharedInstance()
        try!session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try!audioRecorder = AVAudioRecorder(URL:filepath!,settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        

    }
    @IBAction func stoprecording(sender: AnyObject) {
        print("stop recording button pressed")
        recordbutton.enabled=true
        StopRecord.enabled=false
        recordLabel.text="Tap to record"
        audioRecorder.stop()
        let audiosession =  AVAudioSession.sharedInstance()
        try!audiosession.setActive(false)
        }
    override func viewWillAppear(animated: Bool) {
        
        print("view will appear called")
        }
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        print("AVAudioRecorder finished saving recording")
        if (flag) {
            self.performSegueWithIdentifier("stopRecording", sender: audioRecorder.url)
        }else{
            print("saving of recording failed")
        }
        }
   


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC = segue.destinationViewController as!
            PlaysoundsViewController
            let recordedAudioUrl = sender as! NSURL
            playSoundsVC.recordedAudioURl = recordedAudioUrl
            
        }

        
    }}


