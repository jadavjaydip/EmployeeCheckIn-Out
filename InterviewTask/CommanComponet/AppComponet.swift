//
//  AppComponet.swift
//  InterviewTask
//
//  Created by j on 08/10/24.
//

import Foundation
import UIKit
class AppComponet {
    func showAlert(controller: UIViewController, title: String? = "Alert", message: String?, buttonTitle:[String], buttonStyle: [UIAlertAction.Style], handler: @escaping(Int) -> Void) {
        guard let mess = message else { return }
        let alert = UIAlertController(title: title, message: mess, preferredStyle: .alert)
        for i in 0..<buttonTitle.count {
            let button = UIAlertAction(title: buttonTitle[i], style: buttonStyle[i]) { action in
            handler(i)
            }
            alert.addAction(button)
        }
        DispatchQueue.main.async {
            controller.present(alert, animated: true)
        }
    }
    
}
