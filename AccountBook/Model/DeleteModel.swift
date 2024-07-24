//
//  DeleteModel.swift
//  AccountBook
//
//  Created by jaegu park on 7/23/24.
//

import Foundation

struct DeleteModel : Encodable {
    let id: Int
}

struct DeleteResultModel : Codable {
    var id: Int
}
