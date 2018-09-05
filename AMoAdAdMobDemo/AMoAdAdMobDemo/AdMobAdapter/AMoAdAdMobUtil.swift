//
//  AMoAdAdMobUtil.swift
//  AMoAdAdMobDemo
//
//  Created by 菅原 清吾 on 2018/08/28.
//  Copyright © 2018年 com.amoad. All rights reserved.
//

import Foundation
import UIKit

class AMoAdAdMobUtil {
    
    /// - Parameter parameter: AdMob CustomEvent Parameter Object
    /// - Returns: InfeedAfioCustomEventData
    static func extractInfeedAfioCustomEventData(parameter: String) -> InfeedAfioCustomEventData? {

        if let jsonData = parameter.data(using: .utf8) {
            let customEventData = try! JSONDecoder().decode(InfeedAfioCustomEventData.self, from: jsonData)
            return customEventData
        } else {
            return nil
        }
    }
}

struct InfeedAfioCustomEventData: Codable {
    var sid: String
    var file: String
}
