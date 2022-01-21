//
//  ChartLegendsView.swift
//  Bareksa-TakeHome
//
//  Created by Iqbal Zauqul Adib on 21/01/22.
//

import Foundation
import UIKit
import SnapKit

class ChartLegendsView: UIView {
    
    private lazy var containerBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        view.layer.cornerRadius = 4
        return view
    }()
    
    private lazy var containerStackView: UIStackView = {
        var stack = UIStackView()
        stack.layoutMargins = UIEdgeInsets(top: 6, left: 4, bottom: 6, right: 4)
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.axis = .horizontal
        stack.spacing = 5
        
        return stack
    }()
    
    lazy var firstValueLbl: UILabel = {
        return ChartLegendsView.valueLbl()
    }()
    
    lazy var secondValueLbl: UILabel = {
        return ChartLegendsView.valueLbl()
    }()
    
    lazy var thirdValueLbl: UILabel = {
        return ChartLegendsView.valueLbl()
    }()
    
    lazy var dateLbl: UILabel = {
        let label = UILabel()
        label.font = .appFont(ofSize: 12)
        label.textColor = .gray
        label.text = ""
        return label
    }()
    
    lazy var firstIcon: UIView = {
        let icon = ChartLegendsView.valueIcon()
        icon.backgroundColor = .lineBlue
        return icon
        
    }()

    lazy var secondIcon: UIView = {
        let icon = ChartLegendsView.valueIcon()
        icon.backgroundColor = .linePurple
        return icon
    }()
    
    lazy var thirdIcon: UIView = {
        let icon = ChartLegendsView.valueIcon()
        icon.backgroundColor = .lineGreen
        return icon
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addSubview(containerBackgroundView)
        containerBackgroundView.addSubview(containerStackView)
        
        containerBackgroundView.snp.makeConstraints { make in
            make.top.trailing.leading.bottom.equalToSuperview()
        }
        
        containerStackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(6)
            make.bottom.equalToSuperview().offset(-6)
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().offset(-4)
        }
        
        let firstStack = ChartLegendsView.valueStack()
        firstStack.addArrangedSubview(firstIcon)
        firstStack.addArrangedSubview(firstValueLbl)
        
        let secondStack = ChartLegendsView.valueStack()
        secondStack.addArrangedSubview(secondIcon)
        secondStack.addArrangedSubview(secondValueLbl)
        
        let thirdStack = ChartLegendsView.valueStack()
        thirdStack.addArrangedSubview(thirdIcon)
        thirdStack.addArrangedSubview(thirdValueLbl)
        
        containerStackView.addArrangedSubview(firstStack)
        containerStackView.addArrangedSubview(secondStack)
        containerStackView.addArrangedSubview(thirdStack)
        containerStackView.addArrangedSubview(dateLbl)
        
    }
    
}

extension ChartLegendsView {
    private static func valueLbl() -> UILabel{
        let lbl = UILabel()
        lbl.font = .boldAppFont(ofSize: 12)
        lbl.text = ""
        lbl.textColor = .black
        return lbl
    }
    
    private static func valueIcon() -> UIView {
        let view = UIView()
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.productPurple.cgColor
        view.layer.backgroundColor = UIColor.red.cgColor
        
        view.snp.makeConstraints { make in
            make.width.height.equalTo(10)
        }
        view.clipsToBounds = true
        view.layer.cornerRadius = 5

        
        return view
    }
    
    private static func valueStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 2
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }
}
