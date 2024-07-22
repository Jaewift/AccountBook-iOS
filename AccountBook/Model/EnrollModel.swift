//
//  EnrollModel.swift
//  AccountBook
//
//  Created by jaegu park on 7/23/24.
//

import Foundation

struct EnrollModel : Encodable {
    let date: Date
    let type: String
    let category : String
    let price : String
    let cotent : String
}

struct EnrollResultModel : Codable {
    var id: Int
}
