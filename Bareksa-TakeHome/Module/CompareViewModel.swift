//
//  CompareViewModel.swift
//  Bareksa-TakeHome
//
//  Created by Iqbal Zauqul Adib on 19/01/22.
//

import Foundation
import RxSwift
import RxCocoa
import Charts

class CompareViewModel {
    
    //MARK: - Private properties
    private var apiService: APIServiceProtocol
    
    private var disposeBag = DisposeBag()
    
    private var _productDetailsViewModels = PublishRelay<[ProductDetailViewModel]>()
    
    private var _chartData = PublishRelay<LineChartData?>()

    
    //MARK: - Public properties
    var productDetailsViewModels: Driver<[ProductDetailViewModel]> {
        _productDetailsViewModels.asDriver(onErrorJustReturn: [])
    }
    
    var chartData: Driver<LineChartData> {
        _chartData
            .asDriver(onErrorJustReturn: nil)
            .compactMap{$0}
    }
    
    init(apiService: APIServiceProtocol = ApiService()) {
        self.apiService = apiService
    }
    
    func viewDidLoad() {
        getProductDetails()
        getChartData()
    }
    
    private func getProductDetails() {
        apiService
            .getProducts(productCodes: ["test"])
            .map {
               return $0.data
            }
            .map {
                $0.map{ product in
                    ProductDetailViewModel(model: product)
                }
            }
            .subscribe(on: MainScheduler.instance)
            .subscribe { [weak self] productDetailsViewModels in
                self?._productDetailsViewModels.accept(productDetailsViewModels)
            } onFailure: { error in
                
            }.disposed(by: disposeBag)

    }
    
    private func getChartData() {
        apiService
            .getCharts(productCodes: ["test"])
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .map {
                return $0.data
            }
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] chartData in
                self?.handleChartData(data: chartData)
            } onFailure: { error in
                
            }.disposed(by: disposeBag)

    }
    
    private func handleChartData(data: [String:ChartDataResponse.ChartData]) {
            
            var arr = [[ChartDataResponse.ChartData.Data]]()
            
            for chartData in data {
                arr.append(chartData.value.data)
            }
            
            let lineChartData = LineChartData()
            
            for (index,item) in arr.enumerated() {
                
                var dataEntries: [ChartDataEntry] = []
                
                for chartData in item {
                    print(chartData.date)
                    let x = chartData.date.miliSecFromDate(dateFormat: "yyyy-MM-dd")
                    let y = chartData.growth
                    let dataEntry = ChartDataEntry(x: x, y: y)
                    dataEntries.append(dataEntry)
                }
                
                let lineChartDataSet = LineChartDataSet(entries: dataEntries,label: nil)
                lineChartDataSet.mode = .linear
                lineChartDataSet.drawCirclesEnabled = false
                lineChartDataSet.drawHorizontalHighlightIndicatorEnabled = false
                lineChartDataSet.lineWidth = 3
//                lineChartDataSet.colors = UIColor
                
                //duplicate data set for drawing circle
                let lineChartDataSetDup = LineChartDataSet(entries: [ChartDataEntry(x: dataEntries.last!.x, y: dataEntries.last!.y, data: true)],label: nil)
                lineChartDataSetDup.mode = .linear
                lineChartDataSetDup.drawCirclesEnabled = true
                lineChartDataSetDup.drawHorizontalHighlightIndicatorEnabled = false
                lineChartDataSetDup.lineWidth = 3
            
                
//                chartDataTuple.append((lineChartDataSet,lineChartDataSetDup))
                lineChartData.addDataSet(lineChartDataSet)
//                lineChartData.addDataSet(lineChartDataSetDup)
            }
            
           
            _chartData.accept(lineChartData)
        }
    
   
    
}

extension CompareViewModel {
    
    struct ProductDetailViewModel {
        var productTitle: String {
            model.name
        }
        var productImage: URL {
            URL(string: model.details.im_avatar)!
        }
        
        
        var detail: [ProductInfo] {
            [
                ProductDetailViewModel.ProductInfo(title: "Jenis Reksa Dana", value: model.details.type),
                ProductDetailViewModel.ProductInfo(title: "Imbal Hasil", value: formatImbalHasil()),
                ProductDetailViewModel.ProductInfo(title: "Dana Kelolaan", value: calculateDanaKelolaan()),
                ProductDetailViewModel.ProductInfo(title: "Min. Pembelian", value: calculateMinPembelian()),
                ProductDetailViewModel.ProductInfo(title: "Jangka Waktu", value: calculateJangkaWaktu()),
                ProductDetailViewModel.ProductInfo(title: "Tingkat Resiko", value: calculateResiko()),
                ProductDetailViewModel.ProductInfo(title: "Peluncuran", value: calculatePeluncuran())
                
            ]
        }
        
        private var model: ProductDetailResponse.Product
        
        init(model: ProductDetailResponse.Product) {
            self.model = model
        }
        
        private func formatImbalHasil() -> String {
            switch model.details.type {
            case "Pasar Uang":
                return String(String(model.details.return_one_year) + "% / thn")
            case "Saham":
                return String(String(model.details.return_five_year) + "% / 5 thn")
            default:
                return ""
            }
            }
            
        
        
        private func calculateDanaKelolaan() -> String {
            (Double(model.details.total_unit) * model.details.nav).formattedPrice
        }
        
        private func calculateMinPembelian() -> String {
            Double(model.details.min_subscription).formattedPrice
        }
        
        private func calculateJangkaWaktu() -> String {
            switch model.details.type {
            case "Pasar Uang":
                return "1 tahun"
            case "Saham":
                return "5 tahun"
            default:
                return ""
            }
        }
        
        private func calculateResiko() -> String {
            switch model.details.type {
            case "Pasar Uang":
                return "Rendah"
            case "Saham":
                return "Tinggi"
            default:
                return ""
            }
        }
        
        private func calculatePeluncuran() -> String {
            model.details.inception_date.stringDateFormatter()
        }
        

        struct ProductInfo {
            let title: String
            let value: String
        }
    }
    
}
