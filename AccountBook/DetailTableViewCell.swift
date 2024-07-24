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
        if (detailData.type == 1) {
            cell.priceLabel.text = "-" + String(detailData.price)
        } else {
            cell.priceLabel.text = String(detailData.price)
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
}
