//
//  AddViewController.swift
//  AccountBook
//
//  Created by jaegu park on 7/11/24.
//

import UIKit

enum IncomeExpense: Int{
    case Income
    case Expense
}

class AddViewController: UIViewController {
    
    @IBOutlet weak var incomeExpenseSegment: UISegmentedControl!
    @IBOutlet weak var calendarView: UIView!
    @IBOutlet weak var lineLabel: UILabel!
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var costTextField: UITextField!
    
    @IBOutlet weak var completeButton: UIButton!

    private lazy var dateLabel = UILabel()
    private lazy var previousButton = UIButton()
    private lazy var nextButton = UIButton()
    private lazy var weekStackView = UIStackView()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let calendar = Calendar.current
    private let dateFormatter = DateFormatter()
    private let postDateFormatter = DateFormatter()
    private var calendarDate = Date()
    private var days = [String]()
    private var postdateData: String = ""
    
    private var enrollData: EnrollResultModel!
    private var modifyData: ModifyResultModel!
    
    var incomeOrExpense: Int = 0
    
    var buttonText: String = "완료하기"

    var incomeOrExpenseData: String = ""
    var dateData: String = ""
    var categoryData: String = ""
    var contentData: String = ""
    var costData: Int = 0
    var idData: Int = 0
    
    let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont(name: "SFPro-Semibold", size: 13)]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.calendarView.isHidden = true
        self.lineLabel.isHidden = true
        
        self.dateTextField.isEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            if self.incomeOrExpenseData != "" {
                if self.incomeOrExpenseData == "INCOME" {
                    self.incomeExpenseSegment.selectedSegmentIndex = 0
                } else {
                    self.incomeExpenseSegment.selectedSegmentIndex = 1
                }
                self.dateTextField.text = self.dateData
                self.categoryTextField.text = self.categoryData
                self.contentTextField.text = self.contentData
                self.costTextField.text = "\(self.costData)"
                self.completeButton.setTitle(self.buttonText, for: .normal)
            } else {
                self.incomeExpenseSegment.selectedSegmentIndex = 0
                self.dateTextField.text = ""
                self.categoryTextField.text = ""
                self.contentTextField.text = ""
                self.costTextField.text = ""
                self.completeButton.setTitle(self.buttonText, for: .normal)
            }
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
    
    private func configure() {
        self.configureIncomeExpenseSegment()
        self.configureDateLabel()
        self.configureNextButton()
        self.configurePreviousButton()
        self.configureWeekStackView()
        self.configureWeekLabel()
        self.configureCollectionView()
        self.configureCalendar()
    }
    
    @IBAction func backButton_Tapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func configureIncomeExpenseSegment() {
        self.incomeExpenseSegment.selectedSegmentIndex = 0
        self.incomeExpenseSegment.setTitleTextAttributes(textAttributes as [NSAttributedString.Key : Any], for: .normal)
        self.incomeExpenseSegment.addTarget(self, action: #selector(indexChanged), for: .valueChanged)
    }
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        switch incomeExpenseSegment.selectedSegmentIndex{
        case 0:
            self.incomeOrExpense = IncomeExpense.Income.rawValue
        case 1:
            self.incomeOrExpense = IncomeExpense.Expense.rawValue
        default:
            break
        }
    }
    
    private func configureDateLabel() {
        self.calendarView.addSubview(self.dateLabel)
        self.dateLabel.text = "2024년 7월"
        self.dateLabel.textColor = .white
        self.dateLabel.font = UIFont(name: "SFPro-Semibold", size: 17)
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.dateLabel.topAnchor.constraint(equalTo: self.calendarView.topAnchor, constant: 5),
            self.dateLabel.leadingAnchor.constraint(equalTo: self.calendarView.leadingAnchor, constant: 10),
        ])
    }
    
    private func configurePreviousButton() {
        self.calendarView.addSubview(self.previousButton)
        self.previousButton.setImage(UIImage(named: "AccountBook_Previous"), for: .normal)
        self.previousButton.addTarget(self, action: #selector(didPreviousButtonTouched), for: .touchUpInside)
        self.previousButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.previousButton.widthAnchor.constraint(equalToConstant: 35),
            self.previousButton.heightAnchor.constraint(equalToConstant: 40),
            self.previousButton.centerYAnchor.constraint(equalTo: self.dateLabel.centerYAnchor),
            self.previousButton.trailingAnchor.constraint(equalTo: self.nextButton.leadingAnchor, constant: -5),
        ])
    }
    
    private func configureNextButton() {
        self.calendarView.addSubview(self.nextButton)
        self.nextButton.setImage(UIImage(named: "AccountBook_Next"), for: .normal)
        self.nextButton.addTarget(self, action: #selector(didNextButtonTouched), for: .touchUpInside)
        self.nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.nextButton.widthAnchor.constraint(equalToConstant: 35),
            self.nextButton.heightAnchor.constraint(equalToConstant: 40),
            self.nextButton.centerYAnchor.constraint(equalTo: self.dateLabel.centerYAnchor),
            self.nextButton.trailingAnchor.constraint(equalTo: self.calendarView.trailingAnchor),
        ])
    }
    
    private func configureWeekStackView() {
        self.calendarView.addSubview(self.weekStackView)
        self.weekStackView.distribution = .fillEqually
        self.weekStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.weekStackView.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 20),
            self.weekStackView.leadingAnchor.constraint(equalTo: self.calendarView.leadingAnchor, constant: 8),
            self.weekStackView.trailingAnchor.constraint(equalTo: self.calendarView.trailingAnchor, constant: -8)
        ])
    }
    
    private func configureWeekLabel() {
        let dayOfTheWeek = ["일", "월", "화", "수", "목", "금", "토"]
        
        for i in 0..<7 {
            let label = UILabel()
            label.text = dayOfTheWeek[i]
            label.textAlignment = .center
            label.font = UIFont(name: "SFPro-Semibold", size: 17)
            self.weekStackView.addArrangedSubview(label)
            
            if i == 0 {
                label.textColor = .white
            } else if i == 6 {
                label.textColor = .white
            } else {
                label.textColor = .white
            }
        }
    }
    
    private func configureCollectionView() {
        self.calendarView.addSubview(self.collectionView)
        self.collectionView.backgroundColor = .clear
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(AddCalendarCollectionViewCell.self, forCellWithReuseIdentifier: AddCalendarCollectionViewCell.identifier)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.weekStackView.bottomAnchor, constant: 10),
            self.collectionView.leadingAnchor.constraint(equalTo: self.calendarView.leadingAnchor, constant: 8),
            self.collectionView.trailingAnchor.constraint(equalTo: self.calendarView.trailingAnchor, constant: -8),
            self.collectionView.bottomAnchor.constraint(equalTo: self.calendarView.bottomAnchor)
        ])
    }
    
    private func configureCalendar() {
        let components = self.calendar.dateComponents([.year, .month], from: Date())
        self.calendarDate = self.calendar.date(from: components) ?? Date()
        self.dateFormatter.dateFormat = "yyyy년 MM월"
        self.postDateFormatter.dateFormat = "yyyy-MM"
        self.updateCalendar()
    }
    
    private func startDayOfTheWeek() -> Int {
        return self.calendar.component(.weekday, from: self.calendarDate) - 1
    }
    
    private func endDate() -> Int {
        return self.calendar.range(of: .day, in: .month, for: self.calendarDate)?.count ?? Int()
    }
    
    private func updateTitle(){
        let date = self.dateFormatter.string(from: self.calendarDate)
        self.dateLabel.text = date
    }
    
    private func updateDays(){
        self.days.removeAll()
        let startDayOfTheWeek = self.startDayOfTheWeek()
        let totalDays = startDayOfTheWeek + self.endDate()
        
        for day in Int()..<totalDays {
            if day < startDayOfTheWeek {
                self.days.append("")
                continue
            }
            self.days.append("\(day - startDayOfTheWeek + 1)")
        }
        
        self.collectionView.reloadData()
    }
    
    private func updateCalendar() {
        self.updateDays()
        self.updateTitle()
    }
    
    private func minusMonth(){
        self.calendarDate = self.calendar.date(byAdding: DateComponents(month: -1), to: self.calendarDate) ?? Date()
        self.updateCalendar()
    }
    
    private func plusMonth(){
        self.calendarDate = self.calendar.date(byAdding: DateComponents(month: 1), to: self.calendarDate) ?? Date()
        self.updateCalendar()
    }
    
    @objc private func didPreviousButtonTouched(_ sender: UIButton) {
        self.minusMonth()
    }
    
    @objc private func didNextButtonTouched(_ sender: UIButton) {
        self.plusMonth()
    }
    
    @IBAction func Date_Tapped(_ sender: Any) {
        self.calendarView.isHidden = false
        self.lineLabel.isHidden = false
    }
    
    @IBAction func Enroll_Tapped(_ sender: Any) {
        print(buttonText)
        if buttonText == "완료하기" {
            let parameterDatas = EnrollModel(date: postdateData, type: self.incomeOrExpense, category: categoryTextField.text ?? "", price: Int(costTextField.text ?? "") ?? 0, content: contentTextField.text ?? "")
            APIEnrollPost.instance.SendingPostEnroll(parameters: parameterDatas) { result in self.enrollData = result }
            self.navigationController?.popViewController(animated: true)
        } else {
            let parameterDatas2 = ModifyModel(type: self.incomeOrExpense, date: postdateData, category: categoryTextField.text ?? "", price: Int(costTextField.text ?? "") ?? 0, content: contentTextField.text ?? "")
            APIModifyPut.instance.SendingPut(enrollId: idData, parameters: parameterDatas2) { result in self.modifyData = result }
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension AddViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let date = self.dateFormatter.string(from: self.calendarDate)
        let postDate = self.postDateFormatter.string(from: self.calendarDate)
        if (Int(days[indexPath.item]) ?? 0 >= 10) {
            dateTextField.text = "\(date) \(days[indexPath.item])일"
            postdateData = "\(postDate)-\(days[indexPath.item])"
        } else {
            dateTextField.text = "\(date) 0\(days[indexPath.item])일"
            postdateData = "\(postDate)-0\(days[indexPath.item])"
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddCalendarCollectionViewCell.identifier, for: indexPath) as? AddCalendarCollectionViewCell else { return UICollectionViewCell() }
        cell.updateDay(day: self.days[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.weekStackView.frame.width / 7
        return CGSize(width: width, height: width * 0.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}
