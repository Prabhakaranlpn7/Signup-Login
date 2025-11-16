//
//  CommonUIFunctions.swift
//  Login_Swfit
//
//  Created by Prabhakaran on 14/11/25.
//



import UIKit

func addLeftIcon(_ image: UIImage, to textField: UITextField) {
    let iconView = UIImageView(image: image)
    iconView.contentMode = .scaleAspectFit
    iconView.tintColor = .gray
    
    let container = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 24))
    iconView.frame = CGRect(x: 10, y: 0, width: 24, height: 24)
    container.addSubview(iconView)

    textField.leftView = container
    textField.leftViewMode = .always
}



func addAddributedText(_ text:String, rangeText:String, to Lable:UILabel){
    
    let fullText = text
    let attributedString = NSMutableAttributedString(string: fullText)

    let registerRange = (fullText as NSString).range(of: rangeText)

    attributedString.addAttribute(.foregroundColor, value: UIColor.red, range: registerRange)
    attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: registerRange)

    Lable.attributedText = attributedString
    Lable.isUserInteractionEnabled = true

    
}
