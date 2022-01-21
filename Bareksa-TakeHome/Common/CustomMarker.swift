//
//  CustomMarker.swift
//  Bareksa-TakeHome
//
//  Created by Iqbal Zauqul Adib on 20/01/22.
//

import Foundation
import Charts
import SnapKit
import UIKit

class CircleMarker: MarkerView {
    
    lazy var view: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        view.layer.cornerRadius = view.frame.width/2
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
            super.init(coder: coder)
            setup()
        }
    
    override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        print("Content Refresh")
        let index = entry.data as! Int
        switch index {
        case 0:
            view.backgroundColor = .lineGreen
        case 1:
            view.backgroundColor = .linePurple
         default:
            view.backgroundColor = .lineBlue



        }
    }
    
    func setup() {

        addSubview(view)
        self.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        self.offset = CGPoint(x: -(self.frame.width/2), y: -self.frame.height/2)
    }
    

    
    
}


