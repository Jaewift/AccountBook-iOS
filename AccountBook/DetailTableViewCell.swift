//
//  DetailTableViewCell.swift
//  AccountBook
//
//  Created by jaegu park on 7/22/24.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "AddVC") as? AddViewController else { return }
        
        let detailData = detailDatas[indexPath.section]
        nextVC.incomeOrExpenseData = detailData.type
        nextVC.dateData = detailData.date
        nextVC.categoryData = detailData.category
        nextVC.costData = detailData.price
        nextVC.contentData = detailData.content
        nextVC.buttonText = "수정하기"
        nextVC.idData = detailData.id
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return detailDatas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Detail_TableViewCell", for: indexPath) as! DetailTableViewCell
        
        let detailData = detailDatas[indexPath.section]
        
        cell.categoryLabel.text = detailData.category
        cell.contentLabel.text = detailData.content
        if (detailData.type == "EXPANSE") {
            cell.priceLabel.text = "-" + String(detailData.price)
        } else {
            cell.priceLabel.text = String(detailData.price)
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: nil) { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            print("삭제 클릭 됨")
            let detailData = self.detailDatas[indexPath.section]
            let parmeterDatas = DeleteModel(id: detailData.id)
            APIDelete.instance.SendingDelete(enrollId: detailData.id, parameters: parmeterDatas)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
                  self.getViewDetail()
            }
            success(true)
        }
        delete.backgroundColor = .black
        delete.title = "삭제"
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
