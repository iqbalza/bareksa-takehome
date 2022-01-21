//
//  SafeAea.swift
//  Bareksa-TakeHome
//
//  Created by Iqbal Zauqul Adib on 20/01/22.
//
import UIKit
import SnapKit

extension UIView {

  var safeTopAnchor: ConstraintItem {
    if #available(iOS 11.0, *) {
        return safeAreaLayoutGuide.snp.top
    }
      return snp.top
  }

  var safeLeftAnchor: ConstraintItem {
    if #available(iOS 11.0, *){
        return safeAreaLayoutGuide.snp.leading
    }
      return snp.leading
  }

  var safeRightAnchor: ConstraintItem {
    if #available(iOS 11.0, *){
        return safeAreaLayoutGuide.snp.trailing
    }
      return snp.trailing
  }

  var safeBottomAnchor: ConstraintItem {
    if #available(iOS 11.0, *) {
        return safeAreaLayoutGuide.snp.bottom
    }
      return snp.bottom
  }
}
