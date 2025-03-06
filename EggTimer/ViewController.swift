//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Modified by Carter Altman
//  Copyright © 2019 The App Brewery. All rights reserved.
//
//  Added Tick and Alarm Sounds when the timer ends
//  Added a label so the user can see the time remaining with correct constraints to center under the bar




import UIKit
import AVFoundation

class ViewController: UIViewController {
    var audioPlayer: AVAudioPlayer?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var timerLabel: UILabel!
    
    
    let eggTimes = ["Soft":3, "Medium":4, "Hard":7]
    
    var totalTime = 0
    var secondsPassed = 0
    var secondsRemaining = 0
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerLabel.isHidden=true
    }
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {

        timer.invalidate()
        
        
        let hardness = sender.currentTitle!
        
        totalTime=eggTimes[hardness]!
        secondsRemaining=eggTimes[hardness]!
        
        
        
        progressBar.progress = 0.0
        secondsPassed=0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0,target:self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        if secondsPassed < totalTime {
            secondsPassed+=1
            
            timerLabel.text = String(secondsRemaining)
            secondsRemaining-=1
            timerLabel.isHidden=false
            
            let percentageProgress = Float(secondsPassed)/Float(totalTime)
            progressBar.progress=percentageProgress
            playTickSound()
            
        } else {
            playAlarmSound()
            timer.invalidate()
            titleLabel.text = "DONE"
            timerLabel.isHidden=true
            
        }
        
    }
    
    func playAlarmSound() {
        guard let soundURL = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error)")
        }
    }
    func playTickSound() {
        guard let soundURL = Bundle.main.url(forResource: "tick", withExtension: "mp3") else { return }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error)")
        }
    }
    
    
}
    
    
            

