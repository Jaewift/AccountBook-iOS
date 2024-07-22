//
//  AddCalendarCollectionViewCell.swift
//  AccountBook
//
//  Created by jaegu park on 7/13/24.
//

import UIKit

class AddCalendarCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "AddCalendarCollectionViewCell"
    
    private lazy var dayLabel = UILabel()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureDay()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureDay()
    }
    
    override func prepareForReuse() {
        self.dayLabel.text = nil
    }
    
    override var isSelected: Bool {
      didSet {
        if isSelected {
            dayLabel.textColor = UIColor(red: 43/255, green: 217/255, blue: 104/255, alpha: 1)
        } else {
            dayLabel.textColor = .white
        }
      }
    }
    
    private func configureDay() {
        self.addSubview(self.dayLabel)
        self.dayLabel.textColor = .white
        self.dayLabel.font = UIFont(name: "SFPro-Regular", size: 20)
        self.dayLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.dayLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.dayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    func updateDay(day: String) {
        self.dayLabel.text = day
    }
}
