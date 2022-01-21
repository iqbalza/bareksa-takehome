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
        title = "Perbandingan"
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
                        (dataSet as! LineChartDataSet).colors = [CompareView.getLineColor(index: index)]
                    }
                    self.myView.lineChartView.data = data
                })
            .disposed(by: disposeBag)
        
        viewModel.legendValues
            .drive ( onNext: { [weak self] legendViewModel in
                if let thirdValue = legendViewModel.thirdValue {
                    self?.myView.chartLegendsView.thirdIcon.isHidden = false
                    self?.myView.chartLegendsView.thirdValueLbl.text = thirdValue
                } else {
                    self?.myView.chartLegendsView.thirdIcon.isHidden = true

                }
                self?.myView.chartLegendsView.firstValueLbl.text = legendViewModel.firstValue
                self?.myView.chartLegendsView.secondValueLbl.text = legendViewModel.secondValue
                self?.myView.chartLegendsView.dateLbl.text = legendViewModel.date
            }).disposed(by: disposeBag)

    }
    
}

extension CompareViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
            
        var toHighlights = [Highlight]()
        var entries = [ChartDataEntry]()
        for (index, dataSet) in chartView.data!.dataSets.enumerated() {
            let toHighlight = Highlight(x: highlight.x, y: Double.nan, dataSetIndex: index )
            toHighlights.append(toHighlight)
            
            let entry = dataSet.entriesForXValue(highlight.x)
            entries.append(contentsOf: entry)
        }
        myView.lineChartView.highlightValues(toHighlights)
        
        viewModel.valueDidSelect(entry: entries)

        }
}
