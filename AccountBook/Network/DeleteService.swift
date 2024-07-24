//
//  DeleteService.swift
//  AccountBook
//
//  Created by jaegu park on 7/23/24.
//

import Foundation
import Alamofire

class APIDelete {
    static let intnstance = APIDelete()
    
    func SendingDelete(enrollId: Int, parameters: DeleteModel, handler: @escaping (_ result: DeleteResultModel)->(Void)) {
        let url = APIConstants.enrollURL + "/\(enrollId)"
        let headers:HTTPHeaders = [
            "content-type": "application/json"
        ]
        
        AF.request(url, method: .delete, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).response { responce in
            switch responce.result {
            case .success(let data):
                print(String(decoding: data!, as: UTF8.self))
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
                    print(json)
                    
                    let jsonresult = try JSONDecoder().decode(DeleteResultModel.self, from: data!)
                    handler(jsonresult)
                    print(jsonresult)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
