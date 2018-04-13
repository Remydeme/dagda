//
//  tools.swift
//  dagda
//
//  Created by remy DEME on 13/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation
import UIKit


func fontWith(_ size : CGFloat) -> UIFont {
    let font = UIFont(name: "Futura", size: size)
    return font!
}

func labelWith(_ text : String) -> UILabel{
    let label = UILabel()
    label.font = fontWith(16)
    label.numberOfLines = 2
    label.lineBreakMode = .byCharWrapping
    label.textColor = .black
    return label
}


func labelWith(_ text : String, size : CGFloat) -> UILabel{
    let label = UILabel()
    label.font = fontWith(size)
    label.numberOfLines = 2
    label.lineBreakMode = .byCharWrapping
    label.textColor = .black
    return label
}
