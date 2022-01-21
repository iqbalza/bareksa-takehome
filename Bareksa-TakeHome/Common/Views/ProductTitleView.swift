//
//  TitleInfoView.swift
//  Bareksa-TakeHome
//
//  Created by Iqbal Zauqul Adib on 20/01/22.
//

import UIKit
import SnapKit

class ProductTitleView: UIView {
    
    
    var color: UIColor
    
    lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = color
        containerView.layer.cornerRadius = 4
        containerView.alpha = 1
        return containerView
    }()
    
    lazy var titleLbl: UILabel = {
        let titleLbl = UILabel()
        titleLbl.text = "Sucorinvest Money Fund"
        titleLbl.textColor = .black
        titleLbl.font = .appFont(ofSize: 12)
        titleLbl.numberOfLines = 0
        return titleLbl
    }()
    
    lazy var logoImageView: UIImageView = {
       let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "add")
       return logoImageView
    }()
    
    init(color: UIColor) {
        self.color = color
        super.init(frame: .zero)
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
            make.top.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(40)
        }
        
        titleLbl.snp.makeConstraints { (make) in
            make.top.equalTo(logoImageView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.trailing.lessThanOrEqualToSuperview().offset(-16)
        }
        
        
    }
    
    
}
