//
//  Video.swift
//  Play Local Videos
//
//  Created by David Tran on 4/17/19.
//  Copyright © 2018 Wallie. All rights reserved.
//

import Foundation

struct Video
{
    let authorName: String
    let videoFileName: String
    let description: String
    let thumbnailFileName: String

    static func fetchVideos() -> [Video] {
        return videoList
    }
    static var videoList: [Video] = [videoSample_1, videoSample_2, videoSample_3, videoSample_4, videoSample_5]
}

let videoSample_1 = Video(authorName: "Demo 1", videoFileName: "videoSample_1", description: "This is an example of local video.", thumbnailFileName: "videoSample_1")
let videoSample_2 = Video(authorName: "Demo 2", videoFileName: "videoSample_2", description: "This is an example of local video.", thumbnailFileName: "videoSample_2")
let videoSample_3 = Video(authorName: "Demo 3", videoFileName: "videoSample_3", description: "This is an example of local video.", thumbnailFileName: "videoSample_3")
let videoSample_4 = Video(authorName: "Demo 4", videoFileName: "videoSample_4", description: "This is an example of local video.", thumbnailFileName: "videoSample_4")
let videoSample_5 = Video(authorName: "Demo 5", videoFileName: "videoSample_5", description: "This is an example of local video.", thumbnailFileName: "videoSample_5")
