//
//  ViewController.swift
//  Bad Lib
//
//  Created by Peter Frost on 21/11/2015.
//  Copyright © 2015 Peter Frost. All rights reserved.
//

import UIKit
import AVFoundation

class SpeechViewController: UIViewController, AVSpeechSynthesizerDelegate {
    
    var background = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        speechText.text = makeMadLib()
        self.spokenWordPreviewLabel.alpha = 0
        speakButton.imageView?.contentMode = .scaleAspectFit

        do {
        try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category(rawValue: convertFromAVAudioSessionCategory(AVAudioSession.Category.playback)))
        } catch let error as NSError {
            print("Error: \(error.domain)")
        }
        
        /*background = CAGradientLayer().GreyGradient()
        background.frame = self.view.bounds
        self.view.layer.insertSublayer(background, at:  0)*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        if UIDevice.current.orientation.isLandscape {
            print("landscape")
        } else {
            print("portrait")
        }
        self.background.removeFromSuperlayer()
        background = CAGradientLayer().GreyGradient()
        background.frame = self.view.bounds
        self.view.layer.insertSublayer(background, at: 0)
    }*/
    
    @IBOutlet weak var speechText: UITextView!
    @IBOutlet weak var speakButton: UIButton!
    @IBOutlet weak var spokenWordPreviewLabel: UILabel!
    
    let speech = AVSpeechSynthesizer()
    var numCharacters = Int(0)
    var endCharacters = Int(0)
    var wordLengthDict = [Int: Int]()
    var currentWord = 0
    
    @IBAction func generateMadlib(_ sender: UIButton) {
        StopSynth()
        speechText.text = makeMadLib()
    }
    
    @IBAction func stopButton(_ sender: UIButton) {
        StopSynth()
    }
    
    @IBAction func speakButtonAction(_ sender: UIButton) {
        if (speakButton.currentImage == #imageLiteral(resourceName: "Pause Icon.png")) {
            speech.pauseSpeaking(at: AVSpeechBoundary.immediate)
            speakButton.setImage(#imageLiteral(resourceName: "Play Icon.png"), for: UIControl.State())
        } else {
            if speech.isPaused {
                speech.continueSpeaking()
            } else {
                let defaults = UserDefaults.standard
                let synth = AVSpeechUtterance(string: speechText.text)
                synth.voice = AVSpeechSynthesisVoice(language: defaults.object(forKey: "voiceAccent") as? String ?? "en-GB")
                synth.rate = defaults.object(forKey: "voiceSpeed") as? Float ?? 0.5
                synth.pitchMultiplier = defaults.object(forKey: "voicePitch") as? Float ?? 1.0
                speech.delegate = self
                speech.speak(synth)
                spokenWordPreviewLabel.alpha = 1
                speechText.alpha = 0
            }
            speakButton.setImage(#imageLiteral(resourceName: "Pause Icon.png"), for: UIControl.State())
        }
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        var numWords = 0
        var inspect: Character
        let sideWords = 2
        let mutableAttributedString = NSMutableAttributedString(string: utterance.speechString)
        let mutableAttributedPreview = NSMutableAttributedString(string: utterance.speechString)
        
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: characterRange)
        
        mutableAttributedPreview.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: characterRange)
        
        if wordLengthDict.isEmpty {
            repeat {
                let index = mutableAttributedString.string.index(mutableAttributedString.string.startIndex, offsetBy: numCharacters)
                inspect = mutableAttributedString.string[index]
                numCharacters += 1
                if inspect == " " {
                    numWords += 1
                    wordLengthDict[numWords] = numCharacters
                }
            } while (numCharacters < mutableAttributedString.length)
        }
        
        if characterRange.location < (wordLengthDict[(wordLengthDict.count - sideWords)]!) {
            let endRangePreview = NSMakeRange(wordLengthDict[(currentWord + sideWords)]!, (mutableAttributedPreview.length - wordLengthDict[(currentWord + sideWords)]!))
            mutableAttributedPreview.deleteCharacters(in: endRangePreview)
        }
        
        if characterRange.location > wordLengthDict[(sideWords - 1)]! {
            let beginingRangePreview = NSMakeRange(0, wordLengthDict[(currentWord - (sideWords - 1))]!)
            mutableAttributedPreview.deleteCharacters(in: beginingRangePreview)
        }
        
        currentWord += 1
        if currentWord == wordLengthDict.count {
            //stopSynth()
        }
        
        speechText.attributedText = mutableAttributedString
        spokenWordPreviewLabel.attributedText = mutableAttributedPreview
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        speechText.attributedText = NSAttributedString(string: utterance.speechString)
    }
    
    func StopSynth() {
        spokenWordPreviewLabel.alpha = 0
        speechText.alpha = 1
        speechText.textColor = UIColor.black
        speech.stopSpeaking(at: AVSpeechBoundary.immediate)
        speakButton.setImage(#imageLiteral(resourceName: "Play Icon.png"), for: UIControl.State())
        currentWord = 0
        numCharacters = 0
        wordLengthDict = [:]
    }
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
	return input.rawValue
}
