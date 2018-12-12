//
//  CircleImage.swift
//  smack
//
//  Created by tarek bahie on 12/12/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import UIKit

@IBDesignable class CircleImage: UIImageView {
    
        override func awakeFromNib() {
            self.setupView()
        }
        override func prepareForInterfaceBuilder() {
            super.prepareForInterfaceBuilder()
            self.setupView()
        }
        func setupView() {
            self.layer.cornerRadius = self.frame.width / 2
            self.clipsToBounds = true
        }
    }
