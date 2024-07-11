//
//  AddViewController.swift
//  AccountBook
//
//  Created by jaegu park on 7/11/24.
//

import UIKit

class AddViewController: UIViewController {
    
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    private lazy var titleLabel = UILabel()
    private lazy var backButton = UIButton()
    private lazy var incomeExpenseSegment = UISegmentedControl()
    private lazy var textfieldStackView = UIStackView()
    private lazy var dateTextField = UITextField()
    private lazy var dateView = UIView()
    private lazy var categoryTextField = UITextField()
    private lazy var contentTextField = UITextField()
    private lazy var costTextField = UITextField()
    
    let items = ["수입", "지출"]
    let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont(name: "SFPro-Semibold", size: 13)]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
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
        self.configureScrollView()
        self.configureContentView()
        self.configureTitleLabel()
        self.configureBackButton()
        self.configureIncomeExpenseSegment()
        self.configureTextFieldStackView()
        self.configureDateTextField()
        self.configureDateView()
        self.configureCategoryTextField()
        self.configureContentTextField()
        self.configureCostTextField()
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
        self.titleLabel.text = "가계부 입력하기"
        self.titleLabel.textColor = .white
        self.titleLabel.font = UIFont(name: "SFPro-Semibold", size: 17)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
        ])
    }
    
    private func configureBackButton() {
        self.contentView.addSubview(self.backButton)
        self.backButton.setImage(UIImage(named: "AccountBook_Back"), for: .normal)
        self.backButton.addTarget(self, action: #selector(didBackButtonTouched), for: .touchUpInside)
        self.backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.backButton.widthAnchor.constraint(equalToConstant: 35),
            self.backButton.heightAnchor.constraint(equalToConstant: 40),
            self.backButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            self.backButton.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
        ])
    }
    
    @objc func didBackButtonTouched(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func configureIncomeExpenseSegment() {
        self.incomeExpenseSegment = UISegmentedControl(items: items)
        self.contentView.addSubview(self.incomeExpenseSegment)
        self.incomeExpenseSegment.selectedSegmentIndex = 0
        self.incomeExpenseSegment.setTitleTextAttributes(textAttributes as [NSAttributedString.Key : Any], for: .normal)
        self.incomeExpenseSegment.selectedSegmentTintColor = UIColor(red: 99/255, green: 99/255, blue: 102/255, alpha: 1)
        self.incomeExpenseSegment.backgroundColor = UIColor(red: 118/255, green: 118/255, blue: 128/255, alpha: 0.24)
        self.incomeExpenseSegment.addTarget(self, action: #selector(indexChanged), for: .valueChanged)
        self.incomeExpenseSegment.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.incomeExpenseSegment.widthAnchor.constraint(equalToConstant: 114),
            self.incomeExpenseSegment.heightAnchor.constraint(equalToConstant: 24),
            self.incomeExpenseSegment.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 30),
            self.incomeExpenseSegment.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
        ])
    }
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        print("\(sender.selectedSegmentIndex)")
    }
    
    private func configureTextFieldStackView() {
        self.contentView.addSubview(self.textfieldStackView)
        self.textfieldStackView.axis = .vertical
        self.textfieldStackView.alignment = .fill
        self.textfieldStackView.distribution = .equalSpacing
        self.textfieldStackView.spacing = 16
        self.textfieldStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.textfieldStackView.topAnchor.constraint(equalTo: self.incomeExpenseSegment.bottomAnchor, constant: 20),
            self.textfieldStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.textfieldStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.textfieldStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
    
    private func configureDateTextField() {
        self.textfieldStackView.addSubview(self.dateTextField)
        self.dateTextField.layer.cornerRadius = 10
        self.dateTextField.attributedPlaceholder = NSAttributedString(string: "   데이트", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.dateTextField.backgroundColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        self.dateTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.dateTextField.heightAnchor.constraint(equalToConstant: 44),
            self.dateTextField.topAnchor.constraint(equalTo: self.textfieldStackView.topAnchor, constant: 0),
            self.dateTextField.leadingAnchor.constraint(equalTo: self.textfieldStackView.leadingAnchor, constant: 0),
            self.dateTextField.trailingAnchor.constraint(equalTo: self.textfieldStackView.trailingAnchor, constant: 0),
        ])
    }
    
    private func configureDateView() {
        self.textfieldStackView.addSubview(self.dateView)
        self.dateView.backgroundColor = .white
        self.dateView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.dateView.heightAnchor.constraint(equalToConstant: 340),
            self.dateView.topAnchor.constraint(equalTo: self.dateTextField.bottomAnchor, constant: 8),
            self.dateView.leadingAnchor.constraint(equalTo: self.textfieldStackView.leadingAnchor, constant: 0),
            self.dateView.trailingAnchor.constraint(equalTo: self.textfieldStackView.trailingAnchor, constant: 0),
        ])
    }
    
    private func configureCategoryTextField() {
        self.textfieldStackView.addSubview(self.categoryTextField)
        self.categoryTextField.layer.cornerRadius = 10
        self.categoryTextField.attributedPlaceholder = NSAttributedString(string: "   카테고리", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.categoryTextField.backgroundColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        self.categoryTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.categoryTextField.heightAnchor.constraint(equalToConstant: 44),
            self.categoryTextField.topAnchor.constraint(equalTo: self.dateView.bottomAnchor, constant: 8),
            self.categoryTextField.leadingAnchor.constraint(equalTo: self.textfieldStackView.leadingAnchor, constant: 0),
            self.categoryTextField.trailingAnchor.constraint(equalTo: self.textfieldStackView.trailingAnchor, constant: 0),
        ])
    }
    
    private func configureContentTextField() {
        self.textfieldStackView.addSubview(self.contentTextField)
        self.contentTextField.layer.cornerRadius = 10
        self.contentTextField.attributedPlaceholder = NSAttributedString(string: "   내용", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.contentTextField.backgroundColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        self.contentTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.contentTextField.heightAnchor.constraint(equalToConstant: 44),
            self.contentTextField.topAnchor.constraint(equalTo: self.categoryTextField.bottomAnchor, constant: 16),
            self.contentTextField.leadingAnchor.constraint(equalTo: self.textfieldStackView.leadingAnchor, constant: 0),
            self.contentTextField.trailingAnchor.constraint(equalTo: self.textfieldStackView.trailingAnchor, constant: 0),
        ])
    }
    
    private func configureCostTextField() {
        self.textfieldStackView.addSubview(self.costTextField)
        self.costTextField.layer.cornerRadius = 10
        self.costTextField.attributedPlaceholder = NSAttributedString(string: "   금액", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.costTextField.backgroundColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        self.costTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.costTextField.heightAnchor.constraint(equalToConstant: 44),
            self.costTextField.topAnchor.constraint(equalTo: self.contentTextField.bottomAnchor, constant: 16),
            self.costTextField.leadingAnchor.constraint(equalTo: self.textfieldStackView.leadingAnchor, constant: 0),
            self.costTextField.trailingAnchor.constraint(equalTo: self.textfieldStackView.trailingAnchor, constant: 0),
        ])
    }
}
