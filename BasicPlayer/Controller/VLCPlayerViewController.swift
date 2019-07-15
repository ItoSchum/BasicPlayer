//
//  VLCPlayerViewController.swift
//  BasicPlayer
//
//  Created by ItoShen on 5/13/19.
//  Copyright © 2019 ItoSchum. All rights reserved.
//

import UIKit
import AVFoundation

class VLCPlayerViewController: UIViewController, VLCMediaPlayerDelegate {
    
    static var globalVideoPathURL = ""
    
    var vlcPlayer = VLCMediaPlayer()
    
    @IBOutlet weak var playerView: UIView!
    
    @IBAction func prepareForUnwind (segue: UIStoryboardSegue) {
    
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        let segue = UnwindSegue(identifier: unwindSegue.identifier, source: unwindSegue.source, destination: unwindSegue.destination)
        segue.perform()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vlcPlayer.delegate = self
        vlcPlayVideoLaunch()
//        vlcPlayVideoLaunchOnline()
        
        //Add rotation observer
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(UIViewController.rotated),
//            name: NSNotification.Name.UIDeviceOrientationDidChange,
//            object: nil)
        
        //Setup movieView
        self.playerView.backgroundColor = UIColor.gray
        self.playerView.frame = UIScreen.screens[0].bounds
        
        //Add tap gesture to movieView for play/pause
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(UIViewController.movieViewTapped(_:)))
//        self.playerView.addGestureRecognizer(gesture)
//
        //Add movieView to view controller
        self.view.addSubview(self.playerView)
        
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//
//        //Playing multicast UDP (you can multicast a video from VLC)
//        //let url = NSURL(string: "udp://@225.0.0.1:51018")
//
//        //Playing HTTP from internet
//        //let url = NSURL(string: "http://streams.videolan.org/streams/mp4/Mr_MrsSmith-h264_aac.mp4")
//
//        //Playing RTSP from internet
//        let url = URL(string: "rtsp://184.72.239.149/vod/mp4:BigBuckBunny_115k.mov")
//
//        if url == nil {
//            print("Invalid URL")
//            return
//        }
//
//        let media = VLCMedia(url: url!)
//
//        // Set media options
//        // https://wiki.videolan.org/VLC_command-line_help
//        //media.addOptions([
//        //    "network-caching": 300
//        //])
//
//        vlcPlayer.media = media
//
//        vlcPlayer.delegate = self
//        vlcPlayer.drawable = self.playerView
//
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func rotated() {
        
        let orientation = UIDevice.current.orientation
        
//        if (UIDeviceOrientation.isLandscape(orientation)) {
//            print("Switched to landscape")
//        }
//        else if(UIDeviceOrientation.isPortrait(orientation)) {
//            print("Switched to portrait")
//        }
        
        //Always fill entire screen
//        self.movieView.frame = self.view.frame
        
    }
    
    @objc func movieViewTapped(_ sender: UITapGestureRecognizer) {
        
        if vlcPlayer.isPlaying {
            vlcPlayer.pause()
            
            let remaining = vlcPlayer.remainingTime
            let time = vlcPlayer.time
            
            print("Paused at \(time?.stringValue ?? "nil") with \(remaining?.stringValue ?? "nil") time remaining")
        }
        else {
            vlcPlayer.play()
            print("Playing")
        }
        
    }
    
    func vlcPlayVideoLaunch() {
        let inputPath = VLCPlayerViewController.globalVideoPathURL
        let videoPath = Bundle.main.path(forResource: inputPath, ofType: "mp4")
        let videoPathURL = URL(fileURLWithPath: videoPath!)
        let vlcMedia = VLCMedia(url: videoPathURL)
        
        vlcPlayer.media = vlcMedia
        vlcPlayer.drawable = playerView
        vlcPlayer.play()
    }
    
    func vlcPlayVideoLaunchOnline() {
        let pathURL = VLCPlayerViewController.globalVideoPathURL
        let videoPathURL = URL(string: pathURL)
        let vlcMedia = VLCMedia(url: videoPathURL!)
        
        vlcPlayer.media = vlcMedia
        
        vlcPlayer.drawable = playerView
        vlcPlayer.play()
    }
    
    
}


