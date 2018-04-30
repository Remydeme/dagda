//
//  tools.swift
//  dagda
//
//  Created by remy DEME on 13/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation
import UIKit


let itRed = UIColor(red: color(254), green: color(60) , blue: color(69), alpha: 1.0)
let itGreen =  UIColor(red: color(66), green: color(235) , blue: color(194), alpha: 1.0)
let itBlue = UIColor(red: color(81), green: color(250) , blue: color(195), alpha: 1)
let Black = UIColor(red: color(38), green: color(38) , blue: color(38), alpha: 1)
let cellBackground = UIColor(red: color(255), green: color(255) , blue: color(255), alpha: 1)
let homeBlue = UIColor(red: color(51), green: color(191), blue: color(255), alpha: 0.9)
let homeMocha = UIColor(red: color(255), green: color (250), blue: color (244), alpha: 1)

fileprivate let viecolor = UIColor(red: color(38.0), green: color(38.0) , blue: color(38.0), alpha: -1)

fileprivate let viewInpucolor =  UIColor(red: color(38.0), green: color(38.0) , blue: color(38.0), alpha: 0.2)
fileprivate let defaultSize : CGFloat = 17
fileprivate let defaultBigSize : CGFloat = 18
let fontColor = UIColor(red: color(255), green: color(255.0) , blue: color(255.0), alpha: 1)

let fontName = "Optima-Bold"


func fontWith(_ size: CGFloat) -> UIFont
{
    let font = UIFont(name: fontName, size: size)
    return font!
}


func labelWithTitle(_ title : String) -> UILabel
{
    let label = UILabel()
    label.text = title
    label.lineBreakMode = .byCharWrapping
    label.numberOfLines = 3
    label.textColor = fontColor
    label.font = fontWith(defaultSize)
    label.adjustsFontSizeToFitWidth = true
    label.adjustsFontForContentSizeCategory = true
    return label
}

func labelWithTitle(_ title : String, size : CGFloat) -> UILabel
{
    let label = UILabel()
    label.lineBreakMode = .byCharWrapping
    label.numberOfLines = 3
    label.text = title
    label.textColor = fontColor
    label.font = fontWith(size)
    return label
}

func labelWithTitle(_ title : String, _ color : UIColor) -> UILabel
{
    let label = UILabel()
    label.lineBreakMode = .byCharWrapping
    label.numberOfLines = 3
    label.text = title
    label.textColor = fontColor
    label.font = fontWith(defaultBigSize)
    return label
}

func labelWithTitle(_ title : String, _ color : UIColor, font: UIFont) -> UILabel
{
    let label = UILabel()
    label.lineBreakMode = .byCharWrapping
    label.numberOfLines = 3
    label.text = title
    label.textColor = fontColor
    label.font = font
    
    return label
}


func textFieldWith() -> UITextField
{
    let textArea = UITextField()
    textArea.backgroundColor = viewInpucolor
    textArea.textColor = fontColor
    textArea.font =  fontWith(defaultSize)
    return textArea
}



// generate a texte input area
func textViewWith() -> UITextView
{
    let textInput = UITextView()
    textInput.font = fontWith(defaultSize)
    textInput.textColor = fontColor
    textInput.backgroundColor =  viewInpucolor
    textInput.autocapitalizationType = .none
    return textInput
}

// generate a texte input area
func textViewWithDisplay() -> UITextView
{
    let textInput = UITextView()
    textInput.backgroundColor = viecolor
    textInput.textColor = fontColor
    textInput.font = fontWith(defaultSize)
    textInput.autocapitalizationType = .none
    textInput.isEditable = false
    return textInput
}

func textViewWith(backColor : UIColor) ->UITextView
{
    let textInput = UITextView()
    textInput.isEditable = false
    textInput.backgroundColor = .clear
    textInput.font = fontWith(16)
    textInput.autocapitalizationType = .none
    textInput.textColor = fontColor
    return textInput
}

// generate a button with title



func buttonWithTittle(_ title : String, _ type : UIButtonType) -> UIButton
{
    let button = UIButton(type: type)
    button.setTitle(title, for: .normal)
    button.layer.cornerRadius = 5
    button.clipsToBounds = true
    return button
}

// function that generate switch button

func switchButton() -> UISwitch
{
    let button = UISwitch()
    button.setOn(false, animated: true)
    return button
}


