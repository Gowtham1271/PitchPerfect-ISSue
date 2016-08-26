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

    
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var recordbutton: UIButton!
    @IBOutlet weak var StopRecord: UIButton!
    
    var audioRecorder : AVAudioRecorder!
    override func viewWillAppear(animated: Bool) {
        print("viewWillAppear called")
        StopRecord.enabled = false
    }
    
    @IBAction func RecordAudio(sender: AnyObject) {
        
        print("Record button pressed")
        
        recordLabel.text = "recording in Progress"
        StopRecord.enabled = true
        recordbutton.enabled = false
        
        let dirpath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0]as String
        let recordingName = "recordedvoice.m4a"
        let pathArray = [dirpath, recordingName]
        let filepath = NSURL.fileURLWithPathComponents(pathArray)
        print(filepath)
        
        let session = AVAudioSession.sharedInstance()
        try!session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try! session.setActive(true)
        session.requestRecordPermission({ (allowed) in
            
        })
        
        var AvaudioRecorder = [String:AnyObject]()
        AvaudioRecorder[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC)
        AvaudioRecorder[AVSampleRateKey] = 12000.0
        AvaudioRecorder[AVNumberOfChannelsKey] = 1 as NSNumber
        AvaudioRecorder[AVEncoderAudioQualityKey] = AVAudioQuality.High.rawValue
        try!audioRecorder = AVAudioRecorder(URL:filepath!,settings: AvaudioRecorder)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()  
        
        
    }
    
    @IBAction func stopRecording(sender: AnyObject) {
        print("stop recording button")
        recordLabel.text = "Tap to Record"
        StopRecord.enabled = false
        recordbutton.enabled = true
        
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        print("AVAudioRecorder finished saving recording")
        if (flag) {
            self.performSegueWithIdentifier("stoprecording", sender: audioRecorder.url)
        } else {
            print("Saving of recording failed")
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stoprecording") {
            let playSoundsVC = segue.destinationViewController as! PlaysoundsViewController
            let recordedAudioURL = sender as! NSURL
            playSoundsVC.recordedAudioURl = recordedAudioURL
        }
    }
}


