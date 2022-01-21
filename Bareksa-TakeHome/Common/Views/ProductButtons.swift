//
//  ProductButtons.swift
//  Bareksa-TakeHome
//
//  Created by Iqbal Zauqul Adib on 21/01/22.
//

import Foundation
import UIKit
import SnapKit

class ProductButtons: UIView {
    
    lazy var detailBtn: UIButton = {
        let btn = UIButton(type: .roundedRect)
        btn.backgroundColor = .white
        btn.layer.borderColor = UIColor.appDarkGreen.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 4
        let btnLbl = btn.titleLabel
        btn.setTitle("Detail", for: .normal)
        btn.setTitleColor(UIColor.appDarkGreen, for: .normal)
        btnLbl?.font = .boldAppFont(ofSize: 14)
        return btn
    }()
    
    lazy var beliBtn: UIButton = {
        let btn = UIButton(type: .roundedRect)
        btn.backgroundColor = UIColor.appLightGreen
        let btnLbl = btn.titleLabel
        btn.setTitle("Beli", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btnLbl?.font = .boldAppFont(ofSize: 14)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addSubview(detailBtn)
        addSubview(beliBtn)
        
        detailBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.height.equalTo(35)
            make.trailing.leading.equalToSuperview()
        }
        
        beliBtn.snp.makeConstraints { make in
            make.top.equalTo(detailBtn.snp.bottom).offset(5)
            make.height.equalTo(35)
            make.bottom.trailing.leading.equalToSuperview()
        }
    }
    
    
}
