//
//  CoinData.swift
//  ByteCoin
//
//  Created by Xieheng on 2020/01/03.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Codable {
    let last: Double
    let changes: Changes
}

struct Changes: Codable {
    let price: Price
}

struct Price: Codable {
    let hour: Double
}

