//
//  EnrollModel.swift
//  AccountBook
//
//  Created by jaegu park on 7/23/24.
//

import Foundation

struct EnrollModel : Encodable {
    let date: String
    let type: Int
    let category : String
    let price : Int
    let content : String
}

struct EnrollResultModel : Codable {
    var id: Int
    let date: String
    let type: Int
    let category : String
    let price : Int
    let content : String
}
