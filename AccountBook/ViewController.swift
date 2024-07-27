//
//  ViewController.swift
//  AccountBook
//
//  Created by jaegu park on 7/8/24.
//

import UIKit

final class ViewController: UIViewController {
    
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    private lazy var titleLabel = UILabel()
    private lazy var previousButton = UIButton()
    private lazy var nextButton = UIButton()
    private lazy var addButton = UIButton()
    private lazy var weekStackView = UIStackView()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private lazy var lineLabel = UILabel()
    private lazy var summaryLabel = UILabel()
    private lazy var incomeView = UIView()
    private lazy var expenseView = UIView()
    private lazy var incomeLabel = UILabel()
    private lazy var expenseLabel = UILabel()
    private lazy var incomeMoneyLabel = UILabel()
    private lazy var expenseMoneyLabel = UILabel()
    
    private let calendar = Calendar.current
    private let dateFormatter = DateFormatter()
    private var calendarDate = Date()
    private var days = [String]()
    
    private var year: String = ""
    private var month: String = ""
    
    var allDatas: ViewAllModel?
    var allDetailDatas: [ViewAllResponse] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
//        self.getViewAll()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func getViewAll() {
        
        let url = APIConstants.enrollURL + "/\(year)/\(month)"
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
                    let decodedData = try JSONDecoder().decode(ViewAllModel.self, from: safeData)
                    self.allDatas = decodedData
                    self.allDetailDatas = decodedData.enrolls
                    print(allDetailDatas)
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
                        self.incomeMoneyLabel.text = "+\(self.allDatas?.totalIncome ?? 0)"
                        self.expenseMoneyLabel.text = "-\(self.allDatas?.totalExpense ?? 0)"
                    }
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
    
    private func configure() {
        self.configureScrollView()
        self.configureContentView()
        self.configureTitleLabel()
        self.configurePreviousButton()
        self.configureNextButton()
        self.configureAddButton()
        self.configureWeekStackView()
        self.configureWeekLabel()
        self.configureCollectionView()
        self.configureCalendar()
        self.configureLineLabel()
        self.configureSummaryLabel()
        self.configureIncomeView()
        self.configureExpenseView()
        self.configureIncomeLabel()
        self.configureIncomeMoneyLabel()
        self.configureExpenseLabel()
        self.configureExpenseMoneyLabel()
    }
    
    private func configureScrollView() {
        self.view.addSubview(self.scrollView)
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureContentView() {
        self.scrollView.addSubview(self.contentView)
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        ])
    }
    
    private func configureTitleLabel() {
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.text = "2024년 6월"
        self.titleLabel.textColor = .white
        self.titleLabel.font = UIFont(name: "SFPro-Semibold", size: 17)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
        ])
    }
    
    private func configurePreviousButton() {
        self.contentView.addSubview(self.previousButton)
        self.previousButton.tintColor = UIColor(red: 43/255, green: 217/255, blue: 104/255, alpha: 1)
        self.previousButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        self.previousButton.addTarget(self, action: #selector(didPreviousButtonTouched), for: .touchUpInside)
        self.previousButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.previousButton.widthAnchor.constraint(equalToConstant: 40),
            self.previousButton.heightAnchor.constraint(equalToConstant: 40),
            self.previousButton.trailingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor, constant: -5),
            self.previousButton.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor)
        ])
    }
    
    private func configureNextButton() {
        self.contentView.addSubview(self.nextButton)
        self.nextButton.tintColor = UIColor(red: 43/255, green: 217/255, blue: 104/255, alpha: 1)
        self.nextButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        self.nextButton.addTarget(self, action: #selector(didNextButtonTouched), for: .touchUpInside)
        self.nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.nextButton.widthAnchor.constraint(equalToConstant: 40),
            self.nextButton.heightAnchor.constraint(equalToConstant: 40),
            self.nextButton.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 5),
            self.nextButton.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor)
        ])
    }
    
    private func configureAddButton() {
        self.contentView.addSubview(self.addButton)
        self.addButton.setImage(UIImage(named: "AccountBook_Add"), for: .normal)
        self.addButton.addTarget(self, action: #selector(didAddButtonTouched), for: .touchUpInside)
        self.addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.addButton.widthAnchor.constraint(equalToConstant: 35),
            self.addButton.heightAnchor.constraint(equalToConstant: 35),
            self.addButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            self.addButton.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor)
        ])
    }
    
    private func configureWeekStackView() {
        self.contentView.addSubview(self.weekStackView)
        self.weekStackView.distribution = .fillEqually
        self.weekStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.weekStackView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 30),
            self.weekStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            self.weekStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8)
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
        self.contentView.addSubview(self.collectionView)
        self.collectionView.backgroundColor = .clear
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCollectionViewCell.identifier)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.weekStackView.bottomAnchor, constant: 10),
            self.collectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            self.collectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            self.collectionView.heightAnchor.constraint(equalToConstant: 440),
            self.collectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
    
    private func configureCalendar() {
        let components = self.calendar.dateComponents([.year, .month], from: Date())
        self.calendarDate = self.calendar.date(from: components) ?? Date()
        self.dateFormatter.dateFormat = "yyyy년 MM월"
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
        self.titleLabel.text = date
        
        let startIndex = date.startIndex
        let endIndex = date.index(startIndex, offsetBy: 3)
        let substring = date[startIndex...endIndex]
        
        year = "\(substring)"
        
        if date.count == 8 {
            let monthData = String.Index(utf16Offset: 6, in: date)
            month = "\(monthData)"
        } else {
            let monthData = String.Index(utf16Offset: 6, in: date)
            let monthData2 = String.Index(utf16Offset: 7, in: date)
            month = "\(monthData)\(monthData2)"
        }
        
        //        self.getViewAll()
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
        self.updateTitle()
        self.updateDays()
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
    
    @objc private func didAddButtonTouched(_ sender: UIButton) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "AddVC") as? AddViewController else { return }
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func configureLineLabel() {
        self.contentView.addSubview(self.lineLabel)
        self.lineLabel.text = ""
        self.lineLabel.backgroundColor = .white
        self.lineLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.lineLabel.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor, constant: 10),
            self.lineLabel.heightAnchor.constraint(equalToConstant: 1),
            self.lineLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.lineLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
        ])
    }
    
    private func configureSummaryLabel() {
        self.contentView.addSubview(self.summaryLabel)
        let date = self.dateFormatter.string(from: self.calendarDate)
        self.summaryLabel.text = "\(date) 요약"
        self.summaryLabel.textColor = .white
        self.summaryLabel.font = UIFont(name: "SFPro-Semibold", size: 17)
        self.summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.summaryLabel.topAnchor.constraint(equalTo: self.lineLabel.bottomAnchor, constant: 16),
            self.summaryLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
        ])
    }
    
    private func configureIncomeView() {
        self.contentView.addSubview(self.incomeView)
        self.incomeView.backgroundColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        self.incomeView.layer.cornerRadius = 10
        self.incomeView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.incomeView.topAnchor.constraint(equalTo: self.summaryLabel.bottomAnchor, constant: 12),
            self.incomeView.heightAnchor.constraint(equalToConstant: 60),
            self.incomeView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.incomeView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20)
        ])
    }
    
    private func configureExpenseView() {
        self.contentView.addSubview(self.expenseView)
        self.expenseView.backgroundColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        self.expenseView.layer.cornerRadius = 10
        self.expenseView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.expenseView.topAnchor.constraint(equalTo: self.incomeView.bottomAnchor, constant: 10),
            self.expenseView.heightAnchor.constraint(equalToConstant: 60),
            self.expenseView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.expenseView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
        ])
    }
    
    private func configureIncomeLabel() {
        self.contentView.addSubview(self.incomeLabel)
        self.incomeLabel.text = "총 수입"
        self.incomeLabel.textColor = .white
        self.incomeLabel.font = UIFont(name: "SFPro-Regular", size: 17)
        self.incomeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.incomeLabel.leadingAnchor.constraint(equalTo: self.incomeView.leadingAnchor, constant: 16),
            self.incomeLabel.centerYAnchor.constraint(equalTo: self.incomeView.centerYAnchor)
        ])
    }
        
    private func configureExpenseLabel() {
        self.contentView.addSubview(self.expenseLabel)
        self.expenseLabel.text = "총 지출"
        self.expenseLabel.textColor = .white
        self.expenseLabel.font = UIFont(name: "SFPro-Regular", size: 17)
        self.expenseLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.expenseLabel.leadingAnchor.constraint(equalTo: self.expenseView.leadingAnchor, constant: 16),
            self.expenseLabel.centerYAnchor.constraint(equalTo: self.expenseView.centerYAnchor)
        ])
    }
            
    private func configureIncomeMoneyLabel() {
        self.contentView.addSubview(self.incomeMoneyLabel)
        self.incomeMoneyLabel.textColor = UIColor(red: 43/255, green: 217/255, blue: 104/255, alpha: 1)
        self.incomeMoneyLabel.font = UIFont(name: "SFPro-Regular", size: 17)
        self.incomeMoneyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.incomeMoneyLabel.trailingAnchor.constraint(equalTo: self.incomeView.trailingAnchor, constant: -16),
            self.incomeMoneyLabel.centerYAnchor.constraint(equalTo: self.incomeView.centerYAnchor)
        ])
    }
                
    private func configureExpenseMoneyLabel() {
        self.contentView.addSubview(self.expenseMoneyLabel)
        self.expenseMoneyLabel.textColor = UIColor(red: 103/255, green: 140/255, blue: 46/255, alpha: 1)
        self.expenseMoneyLabel.font = UIFont(name: "SFPro-Regular", size: 17)
        self.expenseMoneyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.expenseMoneyLabel.trailingAnchor.constraint(equalTo: self.expenseView.trailingAnchor, constant: -16),
            self.expenseMoneyLabel.centerYAnchor.constraint(equalTo: self.expenseView.centerYAnchor)
        ])
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailViewController else { return }
        
        let monthLabel = titleLabel.text!
        let day = days[indexPath.item]
        
        if titleLabel.text?.count == 8 {
            let month = String.Index(utf16Offset: 6, in: monthLabel)
            nextVC.dateLabel = "\(month)월 \(day)일"
            nextVC.month = "\(month)"
        } else {
            let month = String.Index(utf16Offset: 6, in: monthLabel)
            let month2 = String.Index(utf16Offset: 7, in: monthLabel)
//            let month2 = monthLabel[String.Index(encodedOffset: 7)]
            nextVC.dateLabel = "\(month)\(month2)월 \(day)일"
            nextVC.month = "\(month)\(month2)"
        }
        let startIndex = monthLabel.startIndex
        let endIndex = monthLabel.index(startIndex, offsetBy: 3)
        let substring = monthLabel[startIndex...endIndex]
        
        nextVC.year = "\(substring)"
        nextVC.day = "\(day)"
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.identifier, for: indexPath) as? CalendarCollectionViewCell else { return UICollectionViewCell() }
        cell.updateDay(day: self.days[indexPath.item])
        
        for i in 0..<allDetailDatas.count {
            for j in 0..<days.count {
                if (allDetailDatas[i].type == "INCOME") && (allDetailDatas[i].date.suffix(2) == days[j]){
                    cell.incomeLabel.text = "\(allDetailDatas[i].price)"
                    cell.expenseLabel.text = ""
                } else if (allDetailDatas[i].type == "EXPANSE") && (allDetailDatas[i].date.suffix(2) == days[j]) {
                    cell.incomeLabel.text = ""
                    cell.expenseLabel.text = "\(allDetailDatas[i].price)"
                } else {
                    cell.incomeLabel.text = ""
                    cell.expenseLabel.text = ""
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.weekStackView.frame.width / 7
        return CGSize(width: width, height: width * 1.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}
