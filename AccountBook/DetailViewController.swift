//
//  DetailViewController.swift
//  AccountBook
//
//  Created by jaegu park on 7/11/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var DetailTV: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var detailDatas: [ViewDetailResponse] = []
    var deleteData: DeleteResultModel!
    var dateLabel: String?
    var year: String = ""
    var month: String = ""
    var day: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DetailTV.delegate = self
        DetailTV.dataSource = self
        
        monthDaySend()
//        self.getViewDetail()
    }
    
    func monthDaySend() {
        if let dLabel = dateLabel {
            titleLabel.text = dLabel
            titleLabel.sizeToFit()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func getViewDetail() {
        
        let url = APIConstants.enrollURL + "/\(year)/\(month)/\(day)"
        let encodedStr = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        guard let url = URL(string: encodedStr) else { print("err"); return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { [self] data, response, error in
            if error != nil {
                print("err")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~=
            response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            if let safeData = data {
                print(String(decoding: safeData, as: UTF8.self))
                
                do {
                    let decodedData = try JSONDecoder().decode([ViewDetailResponse].self, from: safeData)
                    self.detailDatas = decodedData
                    DispatchQueue.main.async {
                        self.DetailTV.reloadData()
                    }
                    print(detailDatas)
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
            }
        }.resume()
    }
    
    @IBAction func back_Tapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
