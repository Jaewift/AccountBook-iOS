//
//  DeleteService.swift
//  AccountBook
//
//  Created by jaegu park on 7/23/24.
//

import Foundation
import Alamofire

class APIDelete {
    static let instance = APIDelete()
    
    func SendingDelete(enrollId: Int, parameters: DeleteModel) {
        let url = APIConstants.enrollURL + "/\(enrollId)"
        let headers:HTTPHeaders = [
            "content-type": "application/json"
        ]
        
        AF.request(url, method: .delete, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).response { responce in
            switch responce.result {
            case .success(let data):
                do {
            
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
