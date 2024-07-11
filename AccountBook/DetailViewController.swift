//
//  DetailViewController.swift
//  AccountBook
//
//  Created by jaegu park on 7/11/24.
//

import UIKit

class DetailViewController: UIViewController {

    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    private lazy var titleLabel = UILabel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
