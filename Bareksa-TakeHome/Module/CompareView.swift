//
//  CompareView.swift
//  Bareksa-TakeHome
//
//  Created by Iqbal Zauqul Adib on 20/01/22.
//

import Foundation
import UIKit
import SnapKit

class CompareView: UIView {
    
    static let defaultItemSpacing: CGFloat = 8
    
    static let defaultMargin = 16
    
    lazy var productTitleStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = CompareView.defaultItemSpacing
       return stack
    }()
    
    lazy var productDetailStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = CompareView.defaultItemSpacing
       return stack
    }()
    
    init(){
        super.init(frame: .zero)
        setup()
    }
     
     required init?(coder _: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    func setup() {
        self.backgroundColor = .white
        
        addSubview(productTitleStackView)
        addSubview(productDetailStackView)
        
        productTitleStackView.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeTopAnchor).offset(8)
            make.trailing.equalTo(self.safeRightAnchor).offset(-CompareView.defaultMargin)
            make.leading.equalTo(self.safeLeftAnchor).offset(CompareView.defaultMargin)
        }
        
        productDetailStackView.snp.makeConstraints { (make) in
            make.top.equalTo(productTitleStackView.snp.bottom).offset(16)
            make.trailing.equalTo(self.safeRightAnchor).offset(-CompareView.defaultMargin)
            make.leading.equalTo(self.safeLeftAnchor).offset(CompareView.defaultMargin)
        }
    }
    
    func renderInfoView(productDetailsViewModels: [CompareViewModel.ProductDetailViewModel]) {
        
        for (index,viewModel) in productDetailsViewModels.enumerated() {
            
            var color: UIColor
            switch index {
            case 0:
                color = .productGreen
            case 1:
                color = .productPink
            default:
                color = .productBlue
            }
            
            
            let productTitleView = ProductTitleView(color: color)
            productTitleView.titleLbl.text = viewModel.productTitle
//            productTitleView.logoImageView = viewModel.productImage
            productTitleStackView.addArrangedSubview(productTitleView)
            
            let productDetailVerticalStackview = UIStackView()
            productDetailVerticalStackview.spacing = 16
            productDetailVerticalStackview.distribution = .equalSpacing
            productDetailVerticalStackview.axis = .vertical
            
            for detail in viewModel.detail {
                let productDetailView = ProductDetailView(color: color)
                
                if (index == 0) {
                    productDetailView.titleLbl.text = detail.title
                }
                
                productDetailView.valueLbl.text = detail.value
                productDetailVerticalStackview.addArrangedSubview(productDetailView)
            }
            //buttons
            let buttons = ProductButtons()
            productDetailVerticalStackview.addArrangedSubview(buttons)
            
            productDetailStackView.addArrangedSubview(productDetailVerticalStackview)
        }
        
        
    }
}
