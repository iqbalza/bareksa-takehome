//
//  ViewController.swift
//  Bareksa-TakeHome
//
//  Created by Iqbal Zauqul Adib on 19/01/22.
//

import UIKit
import Charts
import SnapKit
import RxSwift

class CompareViewController: UIViewController {
   
    let viewModel = CompareViewModel()
    
    private let disposeBag = DisposeBag()
    
    lazy var myView: CompareView = {
        let myView = self.view as! CompareView
        return myView
    }()
    
    override func loadView() {
        self.view = CompareView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        bindViewModel()
        viewModel.viewDidLoad()
    }
    
    func setupDelegates() {
        myView.lineChartView.delegate = self
    }
    
    func bindViewModel() {
        viewModel
            .productDetailsViewModels
            .drive(onNext: { [weak self] viewModels in
                self?.myView.renderInfoView(productDetailsViewModels: viewModels)
            })
            .disposed(by: disposeBag)
        
        viewModel
            .chartData
            .drive(
                onNext: { data in
                    for (index, dataSet) in data.dataSets.enumerated() {
                        (dataSet as! LineChartDataSet).colors = [UIColor.getLineColor(index: index)]
                    }
                    self.myView.lineChartView.data = data
                })
            .disposed(by: disposeBag)
    }
    
}

extension CompareViewController: ChartViewDelegate {
    
}
