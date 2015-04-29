//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Jesse Martinez on 3/10/15.
//  Copyright (c) 2015 Jesse Martinez. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    var audioPlayer = AVAudioPlayer()
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate=true
        
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        audioEngine = AVAudioEngine()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func slowDownAudio(sender : UIButton) {
        playAudio(0.5,restart: true)
    }

    @IBAction func playFast(sender : UIButton) {
        playAudio(1.5,restart: true)
    }
    
    @IBAction func playChipmunkMode(sender : UIButton) {
        println("Inside playChipmunkMode")
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playVaderMode(sender : UIButton) {
        println("Inside playVaderMode")
        playAudioWithVariablePitch(-600)

    }
    
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    @IBAction func stopPlayback(sender : UIButton) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
        audioEngine.stop()
        audioEngine.reset()
    }
    
    func playAudio(rate:Float, restart:Bool) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        if(restart == true) {
            audioPlayer.currentTime = 0.0
        }
        audioPlayer.rate = rate
        audioPlayer.prepareToPlay()
        audioPlayer.play()

    }
    
    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
