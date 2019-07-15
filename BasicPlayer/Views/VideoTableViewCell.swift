//
//  VideoTableViewCell.swift
//  BasicPlayer
//
//  Created by ItoShen on 4/17/19.
//  Copyright © 2019 ItoSchum. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var video: Video! {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        thumbnailImageView.image = UIImage(named: video.thumbnailFileName)
        thumbnailImageView.layer.cornerRadius = 10.0
        thumbnailImageView.layer.masksToBounds = true
        nameLabel.text = video.authorName
    }
}
