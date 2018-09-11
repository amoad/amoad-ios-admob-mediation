//
//  Data.swift
//  AMoAdAdMobDemo
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
    static let appID = "管理画面から取得したアプリIDを指定してください"
    static let deviceID = "Test用に端末毎のIDを指定してください"
    static let isSimulator = false // simulatorの場合はtrue 実機の場合はfalseを指定してください
}
