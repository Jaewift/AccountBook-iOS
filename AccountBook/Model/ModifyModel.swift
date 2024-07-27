//
//  ModifyModel.swift
//  AccountBook
//
//  Created by jaegu park on 7/23/24.
//

import Foundation

struct ModifyModel : Encodable {
    let type: Int
    let date: String
    let category : String
    let price : Int
    let content : String
}

struct ModifyResultModel : Codable {
    var id: Int
    let type: Int
    let date: String
    let category : String
    let price : Int
    let content : String
}
