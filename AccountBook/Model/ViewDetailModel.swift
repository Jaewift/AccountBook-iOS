//
//  ViewDetailModel.swift
//  AccountBook
//
//  Created by jaegu park on 7/23/24.
//

import Foundation

struct ViewDetailModel : Codable {
    var results : [ViewDetailResponse]
}

struct ViewDetailResponse : Codable {
    let id: Int
    let date: Date
    let type: String
    let category : String
    let price : String
    let cotent : String
}