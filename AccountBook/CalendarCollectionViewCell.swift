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
    var incomeLabel = UILabel()
    var expenseLabel = UILabel()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureDay()
        self.configureIncome()
        self.configureExpense()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureDay()
        self.configureIncome()
        self.configureExpense()
    }
    
    override func prepareForReuse() {
        self.dayLabel.text = nil
        self.incomeLabel.text = nil
        self.expenseLabel.text = nil
    }
    
    private func configureDay() {
        self.addSubview(self.dayLabel)
        self.dayLabel.textColor = .white
        self.dayLabel.font = UIFont(name: "SFPro-Medium", size: 16)
        self.dayLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.dayLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.dayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    private func configureIncome() {
        self.addSubview(self.incomeLabel)
        self.incomeLabel.textColor = UIColor(red: 43/255, green: 217/255, blue: 104/255, alpha: 1)
        self.incomeLabel.font = UIFont(name: "SFPro-Regular", size: 11)
        self.incomeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.incomeLabel.topAnchor.constraint(equalTo: self.dayLabel.bottomAnchor, constant: 15),
            self.incomeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    private func configureExpense() {
        self.addSubview(self.expenseLabel)
        self.expenseLabel.textColor = UIColor(red: 103/255, green: 140/255, blue: 46/255, alpha: 1)
        self.expenseLabel.font = UIFont(name: "SFPro-Regular", size: 11)
        self.expenseLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.expenseLabel.topAnchor.constraint(equalTo: self.incomeLabel.bottomAnchor, constant: 0),
            self.expenseLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    func updateDay(day: String) {
        self.dayLabel.text = day
    }
}
