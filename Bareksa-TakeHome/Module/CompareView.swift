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
    
    static let defaultItemSpacing: CGFloat = 12
    
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
    
    lazy var chartLegendsView: ChartLegendsView = {
        let view = ChartLegendsView()
        return view
    }()
    
    lazy var lineChartView: LineChartView = {
        let charts = LineChartView()
        charts.backgroundColor = .clear
        charts.legend.enabled = false
        let marker = CircleMarker()
        charts.marker = marker
        charts.extraLeftOffset = CGFloat(CompareView.defaultMargin)
        charts.rightAxis.enabled = true
        charts.leftAxis.enabled = false
        charts.xAxis.labelPosition = .bottom
        charts.xAxis.valueFormatter = XAxisNameFormater()
        charts.xAxis.labelTextColor = .black
        charts.xAxis.granularity = 1.0
        charts.pinchZoomEnabled = false
        let yAxis = charts.rightAxis
        yAxis.labelTextColor = .black
        yAxis.valueFormatter = YAxisNameFormater()
        return charts
    }()
    
    lazy var productTitleStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .horizontal
//        stack.alignment = .center
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
        contentView.addSubview(chartLegendsView)
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
        
        chartLegendsView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(CompareView.defaultMargin)
            make.trailing.lessThanOrEqualToSuperview().offset(-CompareView.defaultMargin)
        }
        
        lineChartView.snp.makeConstraints { (make) in
            make.top.equalTo(chartLegendsView.snp.bottom).offset(CompareView.defaultMargin)
            make.leading.equalToSuperview().offset(CompareView.defaultMargin)
            make.trailing.equalToSuperview().offset(-CompareView.defaultMargin)
            make.height.equalTo(300)
        }
        
        productTitleStackView.snp.makeConstraints { (make) in
            make.top.equalTo(lineChartView.snp.bottom).offset(CompareView.defaultMargin)
            make.trailing.equalToSuperview().offset(-CompareView.defaultMargin)
            make.leading.equalToSuperview().offset(CompareView.defaultMargin)
        }
        
        productDetailStackView.snp.makeConstraints { (make) in
            make.top.equalTo(productTitleStackView.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-CompareView.defaultMargin)
            make.leading.equalToSuperview().offset(CompareView.defaultMargin)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    func renderInfoView(productDetailsViewModels: [CompareViewModel.ProductDetailViewModel]) {
        
        for (index,viewModel) in productDetailsViewModels.enumerated() {
            
            let color: UIColor = CompareView.getProductColor(index: index)
            
            let productTitleView = ProductTitleView(color: color)
            productTitleView.titleLbl.text = viewModel.productTitle
            productTitleView.logoImageView.sd_setImage(with: viewModel.productImage) 
            productTitleStackView.addArrangedSubview(productTitleView)
            
            let productDetailVerticalStackview = UIStackView()
            productDetailVerticalStackview.spacing = 8
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

extension CompareView {
    static func getProductColor(index: Int) -> UIColor {
        switch index {
        case 0:
           return .productGreen
        case 1:
            return .productPurple
        default:
            return .productBlue
        }
}
    static func getLineColor(index: Int) -> UIColor {
        switch index {
        case 0:
           return .lineGreen
        case 1:
            return .linePurple
        default:
            return .lineBlue
        }
    }
}

