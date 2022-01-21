//
//  CompareView.swift
//  Bareksa-TakeHome
//
//  Created by Iqbal Zauqul Adib on 20/01/22.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage
import Charts

class CompareView: UIView {
    
    static let defaultItemSpacing: CGFloat = 8
    
    static let defaultMargin = 16
    
    //MARK: - Views
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var lineChartView: LineChartView = {
        let charts = LineChartView()
        charts.backgroundColor = .clear
        charts.extraLeftOffset = CGFloat(CompareView.defaultMargin)
        charts.rightAxis.enabled = true
        charts.leftAxis.enabled = false
        charts.xAxis.labelPosition = .bottom
        charts.xAxis.valueFormatter = XAxisNameFormater()
        charts.xAxis.granularity = 1.0
        charts.pinchZoomEnabled = false
        let yAxis = charts.rightAxis
        yAxis.setLabelCount(5, force: true)
        yAxis.labelTextColor = .black
        let xAxis = charts.xAxis
        xAxis.setLabelCount(5, force: true)
        return charts
    }()
    
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
        //MARK: -Adding Views
        self.backgroundColor = .white
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(lineChartView)
        contentView.addSubview(productTitleStackView)
        contentView.addSubview(productDetailStackView)
        
        //MARK: -Constraints
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeTopAnchor)
            make.bottom.equalTo(self.safeBottomAnchor)
            make.leading.trailing.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { (make) in
            make.top.bottom.leading.trailing.width.equalToSuperview()
        }
        
        lineChartView.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(CompareView.defaultMargin)
            make.trailing.equalToSuperview().offset(-CompareView.defaultMargin)
            make.height.equalTo(300)
        }
        
        productTitleStackView.snp.makeConstraints { (make) in
            make.top.equalTo(lineChartView.snp.bottom).offset(CompareView.defaultMargin)
            make.trailing.equalToSuperview().offset(-CompareView.defaultMargin)
            make.leading.equalToSuperview().offset(CompareView.defaultMargin)
        }
        
        productDetailStackView.snp.makeConstraints { (make) in
            make.top.equalTo(productTitleStackView.snp.bottom).offset(16)
            make.trailing.equalToSuperview().offset(-CompareView.defaultMargin)
            make.leading.equalToSuperview().offset(CompareView.defaultMargin)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    func renderInfoView(productDetailsViewModels: [CompareViewModel.ProductDetailViewModel]) {
        
        for (index,viewModel) in productDetailsViewModels.enumerated() {
            
            let color: UIColor = .black
            
            let productTitleView = ProductTitleView(color: color)
            productTitleView.titleLbl.text = viewModel.productTitle
            productTitleView.logoImageView.sd_setImage(with: viewModel.productImage) 
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

