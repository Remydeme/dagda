//
//  memberCell.swift
//  dagda
//
//  Created by remy DEME on 16/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation
import UIKit


class MemberCell : BaseCell {

    let id = "CellId"
   

    var toConfirmedController : DescriptionController!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let layout = UICollectionViewFlowLayout()
        toConfirmedController = DescriptionController(collectionViewLayout: layout)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        addSubview((toConfirmedController?.collectionView)!)
    }

    
}
