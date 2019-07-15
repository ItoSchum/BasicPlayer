//
//  OnlineVideoTableViewCell.swift
//  BasicPlayer
//
//  Created by ItoShen on 4/19/19.
//  Copyright © 2019 ItoSchum. All rights reserved.
//

import UIKit

class OnlineVideoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var onlineVideo: OnlineVideo! {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        thumbnailImageView.image = UIImage(named: onlineVideo.thumbnailFileName)
        thumbnailImageView.layer.cornerRadius = 10.0
        thumbnailImageView.layer.masksToBounds = true
        nameLabel.text = onlineVideo.videoFileName
    }
}
