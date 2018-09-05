//
//  Const.swift
//  AMoAdAdMobDemo
//
//  Created by 菅原 清吾 on 2018/08/29.
//  Copyright © 2018年 com.amoad. All rights reserved.
//

import Foundation

struct Item {
    let title: String
    let storyboardName: String
    
    init(title: String, storyboardName: String) {
        self.title = title
        self.storyboardName = storyboardName
    }
}

struct TopList {
    static let items: [Item] = [
        Item(title: "バナー広告", storyboardName: "Banner"),
        Item(title: "インターステイシャル広告", storyboardName: "Interstitial"),
        Item(title: "インフィード AfiO 広告", storyboardName: "InfeedAfio"),
        Item(title: "インターステイシャル AfiO 広告", storyboardName: "InterstitialAfio")
    ]
}

struct AppData {
    static let appID = "ca-app-pub-6717685917384193~5253998125"
    static let deviceID = "fd6605cb61ccc72e33dc27a6836c392c"
    static let isSimulator = false
}
