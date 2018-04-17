//
//  Gradiant.swift
//  dagda
//
//  Created by remy DEME on 14/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation
import UIKit

func color(_ value : CGFloat) ->CGFloat {
    return value / 255
}


class GradientView: UIScrollView{
    
    let darkBlue =  UIColor(red: color(15), green: color(145) , blue: color(189), alpha: 1.0)
    let middleBlue = UIColor(red: color(113), green: color(211) , blue: color(244), alpha: 1)
    let clearBlue = UIColor(red: color(19), green: color(182) , blue: color(236), alpha: 1.0)
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        guard let theLayer = self.layer as? CAGradientLayer else {
            return;
        }
        
        theLayer.colors = [clearBlue.cgColor, middleBlue.cgColor, darkBlue.cgColor]
        theLayer.locations = [0.0, 0.4]
        theLayer.frame = self.bounds
    }
    
}

