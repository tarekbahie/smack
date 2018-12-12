//
//  ColorPlaceHolder.swift
//  smack
//
//  Created by tarek bahie on 12/12/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import UIKit

@IBDesignable class ColorPlaceHolder: UITextField {

    override func awakeFromNib() {
        setUpView()
        
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
    
    func setUpView() {
        if let p = placeholder  {
            let place = NSAttributedString (string: p, attributes: [.foregroundColor: smackPurplePlaceHolder ])
            attributedPlaceholder = place
            textColor = smackPurplePlaceHolder
            
        }
    }
    
    
    
}
