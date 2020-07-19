//
//  GFItemInfoVC.swift
//  GHFollowers
//
//  Created by Jacques Benzakein on 6/22/20.
//  Copyright © 2020 Q Technologies. All rights reserved.
//

import UIKit

class GFItemInfoVC: UIViewController {
    
    let stackView = UIStackView()
    let leftItemInfoView = GFItemInfoView()
    let rightItemInfoView = GFItemInfoView()
    let button = GFButton()
    
    var user: User!
    
    weak var delegate: UserInfoVCDelegate!
    
    let padding: CGFloat = 20

    init(for user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureView()
        configureStackView()
        configureButton()
    }

    private func configureView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func configureStackView() {
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(leftItemInfoView)
        stackView.addArrangedSubview(rightItemInfoView)
    }
    
    private func configureButton() {
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            button.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }

    @objc func didTapButton() {/*empty implementation, meant to be overridden by subclasses*/}
}
