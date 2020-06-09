//
//  GFItemInfoView.swift
//  GHFollowers
//
//  Created by Jacques Benzakein on 6/9/20.
//  Copyright © 2020 Q Technologies. All rights reserved.
//

import UIKit

enum ItemInfoType {
    case repos
    case gists
    case followers
    case following
}

class GFItemInfoView: UIView {

    let sfsymbolView = UIImageView()
    let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSFSymbolView()
        configureTitleLabel()
        configureCountLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    private func configureSFSymbolView() {
        
        addSubview(sfsymbolView)
        sfsymbolView.contentMode = .scaleAspectFill
        sfsymbolView.tintColor = .label
        
        sfsymbolView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sfsymbolView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            sfsymbolView.topAnchor.constraint(equalTo: self.topAnchor),
            sfsymbolView.heightAnchor.constraint(equalToConstant: 20),
            sfsymbolView.widthAnchor.constraint(equalToConstant: 20)
        ])
        
    }
    
    private func configureTitleLabel() {
        
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: sfsymbolView.trailingAnchor, constant: 12),
            titleLabel.centerYAnchor.constraint(equalTo: sfsymbolView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
        
    }
    
    private func configureCountLabel() {
        
        addSubview(countLabel)
        
        NSLayoutConstraint.activate([
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.topAnchor.constraint(equalTo: sfsymbolView.bottomAnchor, constant: 4),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    public func set(itemInfoType: ItemInfoType, with count: Int) {
        
        switch itemInfoType {
        case .repos:
            sfsymbolView.image = UIImage(systemName: SFSymbols.repos)
            titleLabel.text = "Public Repos"
        case .gists:
            sfsymbolView.image = UIImage(systemName: SFSymbols.gists)
            titleLabel.text = "Public Gists"
        case .followers:
            sfsymbolView.image = UIImage(systemName: SFSymbols.followers)
            titleLabel.text = "Followers"
        case .following:
            sfsymbolView.image = UIImage(systemName: SFSymbols.following)
            titleLabel.text = "Following"
        }
        
        countLabel.text = String(count)
    }
}
