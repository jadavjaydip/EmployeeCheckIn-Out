//
//  CardView.swift
//  InterviewTask
//
//  Created by j on 08/10/24.
//

import Foundation
import UIKit
class CardView: UIView {
    
    @IBInspectable var cornerRadiusCustom: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadiusCustom
        }
    }
    
    @IBInspectable var shadowColor: UIColor = .gray {
        didSet {
            self.layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowOffset: CGFloat = 0.0 {
        didSet {
            self.layer.shadowOffset = CGSize(width: shadowOffset, height: shadowOffset)
        }
    }
    
    @IBInspectable var shadowRaius: CGFloat = 0.0 {
        didSet {
            self.layer.shadowRadius = shadowRaius
        }
    }
    
    @IBInspectable var shadowOptiocity: Float = 0.0 {
        didSet {
            self.layer.shadowOpacity = shadowOptiocity
        }
    }
}
