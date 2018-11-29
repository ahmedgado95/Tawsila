//
//  RoundImageView.swift
//  Tawsila
//
//  Created by ahmed gado on 11/29/18.
//  Copyright © 2018 ahmed gado. All rights reserved.
//

import UIKit

class RoundImageView: UIImageView {

    override func awakeFromNib() {
        setupView()
    }
    func setupView(){
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }

}
