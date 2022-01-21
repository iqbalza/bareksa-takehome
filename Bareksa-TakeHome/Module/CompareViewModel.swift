//
//  CompareViewModel.swift
//  Bareksa-TakeHome
//
//  Created by Iqbal Zauqul Adib on 19/01/22.
//

import Foundation
import RxSwift
import RxCocoa

class CompareViewModel {
    
    //MARK: - Private properties
    private var apiService: APIServiceProtocol
    
    private var disposeBag = DisposeBag()
    
    private var _productDetailsViewModels = PublishRelay<[ProductDetailViewModel]>()
    
    //MARK: - Public properties
    var productDetailsViewModels: Driver<[ProductDetailViewModel]> {
        _productDetailsViewModels.asDriver(onErrorJustReturn: [])
    }
    
    init(apiService: APIServiceProtocol = ApiService()) {
        self.apiService = apiService
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
    
    func viewDidLoad() {
        getProductDetails()
    }
    
}

extension CompareViewModel {
    
    struct ProductDetailViewModel {
        var productTitle: String {
            model.name
        }
        var productImage: String {
            model.details.im_avatar
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
