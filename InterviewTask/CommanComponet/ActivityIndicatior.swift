//
//  ActivityIndicatior.swift
//  InterviewTask
//
//  Created by j on 08/10/24.
//

import Foundation
import UIKit
class ActivityIndicatior: NSObject {
    static var loaderView: UIView?
    static var viewBG = UIView()
    
    static func startIndicator(view: UIView? = nil) {
        viewBG = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        viewBG.backgroundColor = UIColor.black.withAlphaComponent(0.08)

        loaderView = view
        let activityIndicationVIew = UIActivityIndicatorView()
        activityIndicationVIew.frame = viewBG.bounds
        activityIndicationVIew.style = .large
        activityIndicationVIew.hidesWhenStopped = true
        activityIndicationVIew.tintColor = UIColor.red
        activityIndicationVIew.color = .red
        activityIndicationVIew.startAnimating()
        viewBG.addSubview(activityIndicationVIew)
        loaderView!.addSubview(viewBG)
    }
    
    static func stopIndicator(view: UIView? = nil){
        if loaderView != nil {
            DispatchQueue.main.async {
                viewBG.removeFromSuperview()
            }
        }
    }
}
