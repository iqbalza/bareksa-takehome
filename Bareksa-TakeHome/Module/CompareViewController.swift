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
        bindViewModel()
        viewModel.viewDidLoad()
    }
    
    func bindViewModel() {
        viewModel.productDetailsViewModels
            .drive(onNext: { [weak self] viewModels in
                self?.myView.renderInfoView(productDetailsViewModels: viewModels)
            })
            .disposed(by: disposeBag)

    }
    
    
    
}
