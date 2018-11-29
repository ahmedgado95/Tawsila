//
//  RoundedShadowButton.swift
//  Tawsila
//
//  Created by ahmed gado on 11/29/18.
//  Copyright © 2018 ahmed gado. All rights reserved.
//

import UIKit

class RoundedShadowButton: UIButton {

    var originalSize: CGRect?
    func setupview(){
        originalSize = self.frame
        self.layer.cornerRadius = 5.0
        self.layer.shadowRadius = 10.0
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize.zero
    }
    override func awakeFromNib() {
        setupview()
    }
    func animateButton(shouldLoad:Bool,withMessage message: String?){
        let spinner = UIActivityIndicatorView()
        spinner.style = .whiteLarge
        spinner.color = UIColor.darkGray
        spinner.alpha = 0.0
        spinner.hidesWhenStopped = true
       
        
        if shouldLoad{
            self.addSubview(spinner)
            
            self.setTitle("", for: .normal)
            UIView.animate(withDuration: 0.2, animations: {
                self.layer.cornerRadius = self.frame.height / 2
                self.frame = CGRect(x:self.frame.midX - (self.frame.height / 2), y:self.frame.origin.y , width:self.frame.height ,height: self.frame.height)},completion:{(finished) in
                    if finished == true{
                        spinner.startAnimating()

                        spinner.center = CGPoint(x:self.frame.width / 2+1 , y:self.frame.width / 2+1 )
                        UIView.animate(withDuration: 0.2, animations: {
                            spinner.alpha = 1.0
                        })
                    }
            })
            self.isUserInteractionEnabled = false
        }else{
            self.isUserInteractionEnabled = true
            for subview in self.subviews{
                if subview.tag == 21{
                    subview.removeFromSuperview()
                }
            }
            UIView.animate(withDuration: 0.2, animations: {
                self.layer.cornerRadius = 5.0
                self.frame = self.originalSize!
                self.setTitle(message, for: .normal)
            })
        }
            
        }

}
