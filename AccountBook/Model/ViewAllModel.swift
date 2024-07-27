//
//  ViewAllModel.swift
//  AccountBook
//
//  Created by jaegu park on 7/23/24.
//

import Foundation

struct ViewAllModel : Codable {
    let totalIncome: Int
    let totalExpense: Int
    var enrolls : [ViewAllResponse]
}

struct ViewAllResponse : Codable {
    let id: Int
    let date: String
    let type: String
    let category : String
    let price : Int
    let content : String
}
