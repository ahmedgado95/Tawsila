//
//  GradientView.swift
//  Tawsila
//
//  Created by ahmed gado on 11/29/18.
//  Copyright © 2018 ahmed gado. All rights reserved.
//

import UIKit

class GradientView: UIView {

    let gradirnt = CAGradientLayer()
    override func awakeFromNib() {
        setGradientView()
    }
    func setGradientView(){
        gradirnt.frame = self.bounds
        gradirnt.colors = [UIColor.white.cgColor,UIColor.init(white: 1.0, alpha: 0.0).cgColor]
        gradirnt.startPoint = CGPoint.zero
        gradirnt.endPoint = CGPoint(x: 0, y: 1)
        gradirnt.locations = [0.8 , 1,0]
        self.layer.addSublayer(gradirnt)
    }
}
