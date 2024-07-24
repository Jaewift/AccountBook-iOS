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
    var dateLabel: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DetailTV.delegate = self
        DetailTV.dataSource = self
        
        monthDaySend()
//        getViewDetail()
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
    
    private func getViewDetail() {
        ViewDetailService.shared.getViewDetail(year: 2024, month: 7, day: 22) { result in
            switch result {
            case .success(let response):
                guard let response = response as? ViewDetailModel else {
                    break
                }
                self.detailDatas = response.results
                
            default:
                break
            }
            self.DetailTV.reloadData()
        }
    }
    
    @IBAction func back_Tapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
