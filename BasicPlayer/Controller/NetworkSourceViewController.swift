//
//  NetworkSourceViewController.swift
//  BasicPlayer
//
//  Created by ItoShen on 4/19/19.
//  Copyright © 2019 ItoSchum. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class NetworkSourceViewController: UIViewController, UITextFieldDelegate, AVPlayerViewControllerDelegate {
    
    @IBOutlet weak var urlTextField: UITextField!
    @IBAction func urlLoad(_ sender: UIButton) {
        playVideo()
    }
    @IBOutlet weak var onlineVideoListTableView: UITableView!
    
    var onlineVideos: [OnlineVideo] = OnlineVideo.fetchVideos()
    var player = AVPlayer()
    var playerViewController = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.onlineVideoListTableView.delegate = self
        self.onlineVideoListTableView.dataSource = self
        self.onlineVideoListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.onlineVideoListTableView.reloadData()
    }
    
    // MARK: Playback Method
    
    func playVideo(at indexPath: IndexPath) {
        let selectedVideo = onlineVideos[indexPath.row]
        let videoPath = selectedVideo.url
        let videoPathURL = URL(string: videoPath)
        player = AVPlayer(url: videoPathURL!)
        playerViewController.player = player
        
        self.present(playerViewController, animated: true, completion: {
            self.playerViewController.player?.play()
        })
        
        playerViewController.allowsPictureInPicturePlayback = true
        playerViewController.delegate = self
    }
    
    func playVideo() {
        let videoPath = urlTextField.text
        let videoPathURL = URL(fileURLWithPath: videoPath!)
        player = AVPlayer(url: videoPathURL)
        playerViewController.player = player
        
        self.present(playerViewController, animated: true, completion: {
            self.playerViewController.player?.play()
        })
        
        playerViewController.allowsPictureInPicturePlayback = true
        playerViewController.delegate = self
    }
    
    // MARK: AVPlayerDelegate Method
    
    func playerViewController(_ playerViewController: AVPlayerViewController, restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler: @escaping (Bool) -> Void) {
        let currentViewController = navigationController?.visibleViewController
        
        if currentViewController != playerViewController {
            currentViewController?.present(playerViewController, animated: true, completion: nil)
        }
    }
    
    
}

extension NetworkSourceViewController: UITableViewDataSource {
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return onlineVideos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OnlineVideoCell", for: indexPath) as! OnlineVideoTableViewCell
        let onlineVideo = onlineVideos[indexPath.row]
        cell.onlineVideo = onlineVideo
        
        return cell
    }
}

extension NetworkSourceViewController: UITableViewDelegate {
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        playVideo(at: indexPath)
    }
    
    
}
