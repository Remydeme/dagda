//
//  timeTableController.swift
//  dagda
//
//  Created by remy DEME on 13/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation
import UIKit


class TimeTableController : UIViewController {
    
    
    var cellView : UIView!
    
    let dictionnary  = ["Subject":labelWith("Subject"), "Time":labelWith("Time"), "Room":labelWith("Room"),    "Day":labelWith("Day")]
    
    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setCellView()
        setLabelConstraint()
        setImage()
    }
    
    func setView(){
        self.view.backgroundColor = .clear
    }
    
    func setCellView(){
        cellView = UIView()
        
        
        //cellView.layer.cornerRadius = 7
        cellView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cellView)
        cellView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        cellView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        let cellViewColor = UIColor(red: color(38), green: color(38), blue: color(38), alpha: 0.5)
        cellView.layer.borderWidth = 0.3
        cellView.backgroundColor = cellViewColor
        cellView.heightAnchor.constraint(equalToConstant: 260).isActive = true
        cellView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
       
        
        
    }
    
    func setUpLabel(){
//        let height : CGFloat = 200
//        let width : CGFloat = 200
//        let top : CGFloat = 20
//        let leading : CGFloat = 30
//        info.translatesAutoresizingMaskIntoConstraints = false
//        cellView.addSubview(info)
//        size(view: info, width: width, height: height)
//        addConstraints(view: info, relative: cellView, top: top, leading: leading)
//        info.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
//        info.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
    }
    
    func setLabelConstraint(){
        
        let height : CGFloat = 10
        let width : CGFloat = 100
        var top : CGFloat = 50
        for (name, labelView) in dictionnary {
            labelView.translatesAutoresizingMaskIntoConstraints = false
            cellView.addSubview(labelView)
            labelView.text = name
            switch name {
            case "Day":
                labelView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 40).isActive = true
                labelView.font = fontWith(22)
                break;
            case "Subject":
                labelView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 100).isActive = true
                labelView.font = fontWith(20)
                break
            case "Time":
                labelView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 140).isActive = true
                labelView.font = fontWith(18)
                break
            case "Room":
                labelView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 180).isActive = true
                labelView.font = fontWith(18)
                break
            default:
                break
            }
           // size(view: view, width: width, height: height)
            labelView.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
        }
    }
    
    
    func setImage(){
        let size : CGFloat = 60
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "image")
        imageView.layer.cornerRadius = 3
        cellView.addSubview(imageView)
        imageView.backgroundColor = .blue
        imageView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10).isActive = true
        imageView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: size).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    func size(view: UIView, width: CGFloat, height : CGFloat){
        view.widthAnchor.constraint(equalToConstant: height).isActive = true
        view.heightAnchor.constraint(equalToConstant: width).isActive = true
    }
    

    
    func addConstraints(view: UIView, relative: UIView, top : CGFloat, leading: CGFloat){
        view.topAnchor.constraint(equalTo: relative.topAnchor, constant: top).isActive = true
        view.leadingAnchor.constraint(equalTo: relative.leadingAnchor, constant: leading).isActive = true
    }
    
}











