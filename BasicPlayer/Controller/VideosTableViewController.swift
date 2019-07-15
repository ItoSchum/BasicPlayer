//
//  VideoTableViewController.swift
//  BasicPlayer
//
//  Created by ItoShen on 4/17/19.
//  Copyright © 2019 ItoSchum. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VideosTableViewController: UITableViewController, AVPlayerViewControllerDelegate
{
    @IBOutlet weak var videoListTableView: UITableView!
    @IBAction func edit(_ sender: UIBarButtonItem) {
        videoListTableView.isEditing = !videoListTableView.isEditing
        
        switch videoListTableView.isEditing {
        case true:
            sender.title = "Done"
        case false:
            sender.title = "Edit"
        }
    }
    
    var videos: [Video] = Video.fetchVideos()
    var player = AVPlayer()
    var playerViewController = AVPlayerViewController()
    
    //    var file = "\(UUID().uudiString)"
    //    let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    //    let videoSamplePicker = UIDocumentPickerViewController
    //    let fileURL = dir.appendingPathComponent(file)
    
    //    MARK: - UITableViewDataSource
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoTableViewCell
        let video = videos[indexPath.row]
        cell.video = video
        
        return cell
    }
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if PlaybackSettingsViewController.hwAccelerationIsOn {
            playVideo(at: indexPath)
        } else {
            vlcPlayVideo(at: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = videos[sourceIndexPath.row]
        self.videos.remove(at: sourceIndexPath.row)
        self.videos.insert(item, at: destinationIndexPath.row)
        Video.videoList.remove(at: sourceIndexPath.row)
        Video.videoList.insert(item, at: destinationIndexPath.row)
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            self.videos.remove(at: indexPath.row)
            
            Video.videoList.remove(at: indexPath.row)
            //            let selectedVideo = videos[indexPath.row]
            //            let videoPath = Bundle.main.path(forResource: selectedVideo.videoFileName, ofType: "mp4")
            //            removeFilePath(videoPath!)
            
            tableView.reloadData()
        }
    }
    
    
    // MARK: Playback Method
    
    func playVideo(at indexPath: IndexPath) {
        let selectedVideo = videos[indexPath.row]
        let videoPath = Bundle.main.path(forResource: selectedVideo.videoFileName, ofType: "mp4")
        let videoPathURL = URL(fileURLWithPath: videoPath!)
        player = AVPlayer(url: videoPathURL)
        playerViewController.player = player
        
        self.present(playerViewController, animated: true, completion: {
            self.playerViewController.player?.play()
        })
        
        playerViewController.allowsPictureInPicturePlayback = true
        playerViewController.delegate = self
        
    }
    
    func vlcPlayVideo(at indexPath: IndexPath) {
        let selectedVideo = videos[indexPath.row]
        VLCPlayerViewController.globalVideoPathURL = selectedVideo.videoFileName
    }
    
    
    // MARK: Navigation Method
    
    //    private func navigateToPlayerInterface() {
    //        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
    //        guard let vlcPlayerViewController = mainStoryBoard.instantiateViewController(withIdentifier: "VLCPlayerViewController") as? VLCPlayerViewController else {
    //            return
    //        }
    //        present(vlcPlayerViewController, animated: true, completion: nil)
    //    }
    
    
    // MARK: AVPlayerDelegate Method
    
    func playerViewController(_ playerViewController: AVPlayerViewController, restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler: @escaping (Bool) -> Void) {
        let currentViewController = navigationController?.visibleViewController
        
        if currentViewController != playerViewController {
            currentViewController?.present(playerViewController, animated: true, completion: nil)
        }
    }
    
    // MARK: removeFilePath
    
    func removeFilePath(_ path: String) {
        let fileManager = FileManager.default
        
        do{
            try fileManager.removeItem(atPath: path)
        } catch {
            print("Remove failed. Path not exsited.")
        }
    }
}

//extension UIView {
//    func add(view: UIView, left: CGFloat, right: CGFloat, top: CGFloat, bottom: CGFloat) {
//
//        view.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(view)
//
//        view.leftAnchor.constraint(equalTo: self.leftAnchor, constant: left).isActive = true
//        view.rightAnchor.constraint(equalTo: self.rightAnchor, constant: right).isActive = true
//
//        view.topAnchor.constraint(equalTo: self.topAnchor, constant: top).isActive = true
//        view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottom).isActive = true
//
//    }
//}
