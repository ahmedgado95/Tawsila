//
//  RoundedShadowView.swift
//  Tawsila
//
//  Created by ahmed gado on 11/29/18.
//  Copyright © 2018 ahmed gado. All rights reserved.
//

import UIKit

class RoundedShadowView: UIView {
    override func awakeFromNib() {
        setupView()
    }

    func setupView(){
        self.layer.cornerRadius = 5.0
        self.layer.shadowOpacity = 0.3
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
    }

}
