//
//  AdditionalInfoView.swift
//  Bareksa-TakeHome
//
//  Created by Iqbal Zauqul Adib on 20/01/22.
//

import Foundation
import UIKit
import SnapKit

class ProductDetailView: UIView {
    
    lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = .appFont(ofSize: 12)
        lbl.text = " "
        lbl.textColor = .gray
        lbl.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return lbl
    }()
    
    lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = color
        containerView.layer.cornerRadius = 4
        return containerView
    }()
    
    lazy var valueLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = .appFont(ofSize: 12)
        lbl.text = "Pasar Uang"
        lbl.textColor = .black
        return lbl
    }()
    
    var color: UIColor
    
    init(color: UIColor) {
        self.color = color
        super.init(frame: .zero)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        
        addSubview(containerView)
        addSubview(valueLbl)
        addSubview(titleLbl)
        
        titleLbl.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.leading.trailing.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.bottom.trailing.leading.equalToSuperview()
            make.top.equalTo(titleLbl.snp.bottom).offset(5)
        }
        
        valueLbl.snp.makeConstraints { (make) in
            make.top.leading.equalTo(containerView).offset(8)
            make.bottom.equalTo(containerView).offset(-8)
            make.trailing.lessThanOrEqualTo(containerView.snp.trailing).offset(-8)
        }
        
    }
    
}
