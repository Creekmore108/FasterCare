//
//  RecordMessageViewController.swift
//  FastERCare
//
//  Created by Steven Creekmore on 12/27/15.
//  Copyright © 2015 Steven Creekmore. All rights reserved.
//

import UIKit
import AVFoundation

class RecordMessageViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    var soundRecorder: AVAudioRecorder!
    var soundPlayer:AVAudioPlayer!
    //var audioPlayer: AVAudioPlayer!
    
    let fileName = "/Message.caf"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRecorder()
    }
    
    @IBAction func recordSound(sender: UIButton) {
        if (sender.titleLabel?.text == "Record"){
            soundRecorder.record()
            sender.setTitle("Stop", forState: .Normal)
            playButton.enabled = false
        } else {
            soundRecorder.stop()
            sender.setTitle("Record", forState: .Normal)
        }
    }
    
    @IBAction func playSound(sender: UIButton) {
        do {
            
            let sound = try AVAudioPlayer(contentsOfURL:getFileURL())
            soundPlayer = sound
            soundPlayer.delegate = self
            soundPlayer.prepareToPlay()
            soundPlayer.volume = 1
            soundPlayer.play()
            print("Inside playsound")
        } catch {
            // couldn't load file :(
        }
        
    }
    
    // - AVRecorder Setup
    
    func setupRecorder() {
        
        //set the settings for recorder
        
        let recordSettings = [AVSampleRateKey : NSNumber(float: Float(44100.0)),
            AVFormatIDKey : NSNumber(int: Int32(kAudioFormatAppleLossless)),
            AVNumberOfChannelsKey : NSNumber(int: 2),
            AVAudioSessionCategoryPlayAndRecord: AVAudioSession.sharedInstance(),
            AVEncoderAudioQualityKey : NSNumber(int: Int32(AVAudioQuality.Max.rawValue))];
        //let session = AVAudioSession.sharedInstance()
        //try!  session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        var error: NSError?
        
        do {
           // soundRecorder = try AVAudioRecorder(URL: getFileURL(), settings: recordSettings as [NSObject : AnyObject])
        soundRecorder =
        try AVAudioRecorder(URL: getFileURL(), settings: recordSettings)
        } catch let error1 as NSError {
            error = error1
            soundRecorder = nil
        }
        
        if let err = error {
            print("AVAudioRecorder error: \(err.localizedDescription)")
        } else {
            soundRecorder.delegate = self
            soundRecorder.prepareToRecord()
        }
    }
    
    //- Prepare AVPlayer
    
    func preparePlayer() {
        var error: NSError?
        
        do {
            soundPlayer = try AVAudioPlayer(contentsOfURL: getFileURL())
            soundPlayer.delegate = self
            soundPlayer.prepareToPlay()
            soundPlayer.volume = 1
            print("inside soundPlayer")
        } catch let error1 as NSError {
            print("inside soundPlayer Error")
            error = error1
          //  soundPlayer = nil
        }
        
        if let err = error {
            print("AVAudioPlayer error: \(err.localizedDescription)")
        } else {
            print("inside preparetoplay: \(getFileURL())")
                    }
    }
    
    // MARK:- File URL
    
    func getCacheDirectory() -> String {
        
        let paths = NSSearchPathForDirectoriesInDomains(.CachesDirectory,.UserDomainMask, true)
        
        print("paths[0]: \(paths[0])")
        
        return paths[0]
    }
    
    func getFileURL() -> NSURL {
        
        let fileManager = NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).first
        let soundURL = fileManager!.URLByAppendingPathComponent("Message.caf")
        print("filePath after: \(soundURL)")
        return soundURL
    }
    
    // MARK:- AVAudioPlayer delegate methods
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        recordButton.enabled = true
        print("DidFinishPlaying")
        playButton.setTitle("Play", forState: .Disabled)
    }
    
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer, error: NSError?) {
        print("Error while playing audio \(error!.localizedDescription)")
    }
    
    // MARK:- AVAudioRecorder delegate methods
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        playButton.enabled = true
        print("DidFinishRecording")
        recordButton.setTitle("Record", forState: .Normal)
    }
    
    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder, error: NSError?) {
        print("Error while recording audio \(error!.localizedDescription)")
    }
    
    // MARK:- didReceiveMemoryWarning
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
