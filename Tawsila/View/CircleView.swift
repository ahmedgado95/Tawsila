//
//  CircleView.swift
//  Tawsila
//
//  Created by ahmed gado on 11/29/18.
//  Copyright © 2018 ahmed gado. All rights reserved.
//

import UIKit

class CircleView: UIView {

    @IBInspectable var borderColor: UIColor? {
        didSet{
            setupView()
        }
    
    }
    override func awakeFromNib() {
        setupView()
    }
    func setupView(){
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.borderWidth = 1.5
        self.layer.borderColor = borderColor?.cgColor
    }
}
