//
//  GFAlertVC.swift
//  GHFollowers
//
//  Created by Jacques Benzakein on 4/13/20.
//  Copyright © 2020 Q Technologies. All rights reserved.
//

import UIKit

class GFAlertVC: UIViewController {

    let containerView = UIView()
    let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = GFBodyLabel(textAlignment: .center)
    let bottomButton = GFButton(withBackgroundColor: .systemPink, title: "Ok")
    
    var alertTitle: String?
    var alertMessage: String?
    var buttonTitle: String?
    
    let padding: CGFloat = 20
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.alertMessage = message
        self.buttonTitle = buttonTitle
        
        configureContainerView()
        configureTitleLabel()
        configureBottomButton() //needs to come before configuring the message label because the message label is contrained to this button and if this button doesn't exist yet, it'll be grasping at something that isn't there
        configureMessageLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
    }
    
    private func configureContainerView() {
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }

    private func configureTitleLabel() {
        
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
        
    }
    
    private func configureMessageLabel() {
        
        containerView.addSubview(messageLabel)
        messageLabel.text = alertMessage ?? "An unknown error has occured"
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: bottomButton.topAnchor, constant: -12)
        ])
    }
    
    private func configureBottomButton() {
        
        containerView.addSubview(bottomButton)
        bottomButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        bottomButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            bottomButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            bottomButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            bottomButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            bottomButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}
