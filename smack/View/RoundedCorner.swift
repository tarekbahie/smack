//
//  RoundedCorner.swift
//  smack
//
//  Created by tarek bahie on 12/10/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import UIKit

@IBDesignable class RoundedCorner: UIButton {
    @IBInspectable var cornerRadius : CGFloat = 5.0{
    didSet{
        self.layer.cornerRadius = cornerRadius
    }
    }
    override func awakeFromNib() {
        self.setupView()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
    func setupView() {
        self.layer.cornerRadius = cornerRadius
    }
}
