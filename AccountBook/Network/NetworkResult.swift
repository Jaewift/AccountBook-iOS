//
//  NetworkResult.swift
//  AccountBook
//
//  Created by jaegu park on 7/23/24.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
