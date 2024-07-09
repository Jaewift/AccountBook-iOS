//
//  CalendarCollectionViewCell.swift
//  AccountBook
//
//  Created by jaegu park on 7/9/24.
//

import UIKit

final class CalendarCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CalendarCollectionViewCell"
    
    private lazy var dayLabel = UILabel()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    override func prepareForReuse() {
        self.dayLabel.text = nil
    }
    
    private func configure() {
        self.addSubview(self.dayLabel)
        self.dayLabel.textColor = .white
        self.dayLabel.font = UIFont(name: "SFPro-Medium", size: 16)
        self.dayLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.dayLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.dayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    func update(day: String) {
        self.dayLabel.text = day
    }
}
