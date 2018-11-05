//
//  OinkRecorderViewController.swift
//  Hoink
//
//  Created by Mike Cameron on 2018-10-09.
//  Copyright © 2018 Mike Cameron. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase
import FirebaseAuth
//import FirebaseFirestore

class OinkRecorderViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var oinkNameTextField: UITextField!
    
    var oinkRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var recordingSession: AVAudioSession!
    var user: User!
    var storageManager = StorageManager()
    var databaseManager = DatabaseManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser != nil {
            let user = Auth.auth().currentUser
            if let user = user {
                let uid = user.uid
                UserDefaults.standard.set(uid, forKey: "UID")
            }
        }
        self.startAudioSession()
    }

    func startAudioSession() {
        
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.setUpRecorder()
                    } else {
                        print("Not allowed to record")
                    }
                }
            }
        } catch {
            print("Error in session setup")
        }
    }
    
    func setUpRecorder() {
        
        let recordSettings = [
            AVFormatIDKey: kAudioFormatAppleLossless,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue,
            AVEncoderBitRateKey: 320000,
            AVNumberOfChannelsKey: 1,
            AVSampleRateKey: 44100.0
            ] as [String : Any]
        
        do {
            oinkRecorder = try AVAudioRecorder(url: getFileURL(), settings: recordSettings)
            oinkRecorder.delegate = self
            oinkRecorder.prepareToRecord()
            playButton.isEnabled = false
        } catch {
            print("error setting up")
        }
    }
    
    func getFileURL() -> URL {
        
        let fm = FileManager.default
        let docsURL = try! fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let filePath = docsURL.appendingPathComponent("oink_file.m4a")
        return filePath
    }
    
    func preparePlayer() {
        
        do {
            audioPlayer = try AVAudioPlayer.init(contentsOf: getFileURL())
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 1.0
        } catch {
            print("Error playing")
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        playButton.isEnabled = true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        recordButton.isEnabled = true
        playButton.setTitle("Play", for: .normal)
    }
    
    // MARK: Button Actions
    
    @IBAction func recordButtonPressed(_ sender: UIButton) {
        
        if sender.titleLabel?.text == "Record Oink" {
            oinkRecorder.record()
            sender.setTitle("Stop", for: .normal)
            playButton.isEnabled = false
        } else {
            oinkRecorder.stop()
            sender.setTitle("Record Oink", for: .normal)
            playButton.isEnabled = false
        }
    }
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        
        if sender.titleLabel?.text == "Play Oink" {
            recordButton.isEnabled = false
            sender.setTitle("Stop", for: .normal)
            preparePlayer()
            audioPlayer.play()
        } else {
            audioPlayer.stop()
            sender.setTitle("Play Oink", for: .normal)
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        if oinkNameTextField.text == "" {
            let alert = UIAlertController(title: "Please name your oink", message: "Come on piggy", preferredStyle: .alert)
            self.present(alert, animated: true)
        }
        
        guard let title = oinkNameTextField.text else { return }
        
        let file = try? Data(contentsOf: self.getFileURL())
        guard let oink = file else { return }
        
        storageManager.storeOink(oink: oink, title: title)
        
    }
    
}
