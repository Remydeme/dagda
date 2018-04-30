//
//  welcome.swift
//  dagda
//
//  Created by remy DEME on 30/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation
import UIKit

class Welcome : UIViewController {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setWelcom()
    }
    
    
    func setUp(){
        let tap = UITapGestureRecognizer(target: self, action: #selector (dismiss(_:)))
        tap.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tap)
        self.view.backgroundColor = .white
    }
    
    func setWelcom(){
        
        
        let cellView = UIView()
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.backgroundColor = itRed
        cellView.layer.cornerRadius = 37
        self.view.addSubview(cellView)
        
        cellView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        cellView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        cellView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cellView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        // label on the cell
        let welcom = labelWithTitle("", size: 27)
        welcom.text =  "Welcom Back"
        welcom.textAlignment = .center
        welcom.translatesAutoresizingMaskIntoConstraints = false
        cellView.addSubview(welcom)
        
        welcom.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10).isActive = true
        welcom.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
        
        welcom.heightAnchor.constraint(equalToConstant: 40).isActive = true
        welcom.widthAnchor.constraint(equalTo: cellView.widthAnchor).isActive = true //
        
        // full name
        let name = User.instance.name + " " + User.instance.firstname
        let fullName = labelWithTitle(name, size: 20)
        fullName.textAlignment = .center
        fullName.translatesAutoresizingMaskIntoConstraints = false
        
        cellView.addSubview(fullName)
        
        fullName.heightAnchor.constraint(equalToConstant: 30).isActive = true
        fullName.widthAnchor.constraint(equalTo: cellView.widthAnchor, multiplier: 0.8).isActive = true
        
        fullName.topAnchor.constraint(equalTo: welcom.bottomAnchor, constant: 15).isActive = true
        fullName.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
        
        let quote = " \"Alone we can do so little together we can do so much\"\n\n #Dadga community" //User.instance.name + " " + User.instance.firstname
        let quoteLabel = labelWithTitle(quote, size: 14)
        quoteLabel.textAlignment = .center
        quoteLabel.lineBreakMode = .byWordWrapping
        quoteLabel.translatesAutoresizingMaskIntoConstraints = false
        
        cellView.addSubview(quoteLabel)
        
        quoteLabel.heightAnchor.constraint(equalToConstant: 90).isActive = true
        quoteLabel.widthAnchor.constraint(equalTo: cellView.widthAnchor, multiplier: 0.8).isActive = true
        
        quoteLabel.topAnchor.constraint(equalTo: fullName.bottomAnchor, constant: 15).isActive = true
        quoteLabel.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
    }
    
    @objc func dismiss(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    
}
