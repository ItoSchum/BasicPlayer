//
//  OnlineVideo.swift
//  BasicPlayer
//
//  Created by ItoShen on 4/19/19.
//  Copyright © 2019 ItoSchum. All rights reserved.
//

import Foundation

struct OnlineVideo
{
    let url: String
    let videoFileName: String
    let description: String
    let thumbnailFileName: String
    
    static func fetchVideos() -> [OnlineVideo] {
        return onlineVideoList
    }
    static var onlineVideoList: [OnlineVideo] = [onlineVideoSample_1, onlineVideoSample_2, onlineVideoSample_3]
}

let onlineVideoSample_1 = OnlineVideo(url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", videoFileName: "Big Buck Bunny", description: "This is an example of online video.", thumbnailFileName: "onlineVideoSample_1")
let onlineVideoSample_2 = OnlineVideo(url: "https://www.apple.com/105/media/us/iphone-xs/2018/674b340a-40f1-4156-bbea-00f386459d3c/films/design/iphone-xs-design-tpl-cc-us-2018_1280x720h.mp4", videoFileName: "iPhone Xs Design Film", description: "This is an example of online video.", thumbnailFileName: "onlineVideoSample_2")
let onlineVideoSample_3 = OnlineVideo(url: "http://ivi.bupt.edu.cn/hls/cctv6hd.m3u8", videoFileName: "CCTV 6 HD (HLS)", description: "This is an example of online video.", thumbnailFileName: "onlineVideoSample_3")
