//
//  TitleInfoView.swift
//  Bareksa-TakeHome
//
//  Created by Iqbal Zauqul Adib on 20/01/22.
//

import UIKit
import SnapKit

class TitleInfoView: UIView {
    
    lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .green
        containerView.layer.cornerRadius = 4
        containerView.alpha = 0.6
        return containerView
    }()
    
    lazy var titleLbl: UILabel = {
        let titleLbl = UILabel()
        titleLbl.text = "Sucorinvest Money Fund"
        titleLbl.textColor = .black
        titleLbl.font = .boldSystemFont(ofSize: 12)
        titleLbl.numberOfLines = 0
        return titleLbl
    }()
    
    lazy var logoImageView: UIImageView = {
       let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "add")
       return logoImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setupConstraints() {
        addSubview(containerView)
        addSubview(titleLbl)
        addSubview(logoImageView)
        
        containerView.snp.makeConstraints { (make) in
            make.top.bottom.trailing.leading.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(8)
            make.width.height.equalTo(30)
        }
        
        titleLbl.snp.makeConstraints { (make) in
            make.top.equalTo(logoImageView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.trailing.lessThanOrEqualToSuperview().offset(-8)
        }
        
        
    }
    
    
}
