//
//  AdminLoginViewController.swift
//  InterviewTask
//
//  Created by j on 08/10/24.
//

import UIKit

class AdminLoginViewController: UIViewController {

    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        if validation() {
            if txtUserName.text == "Admin" && txtPassword.text == "Admin123" {
                userDefaults.set(txtUserName.text, forKey: "adminId")
                userDefaults.set(txtPassword.text, forKey: "adminPassword")
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AdminDashboardViewController") as! AdminDashboardViewController
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                AppComponet().showAlert(controller: self, message: "Please Enter currect credentional", buttonTitle: ["Ok"], buttonStyle: [.default]) { [weak self] _ in }
            }
        }
    }
    
    func validation() -> Bool {
        if (txtUserName.text ?? "").trimmingCharacters(in: .whitespaces).isEmpty {
            AppComponet().showAlert(controller: self, message: "Please Enter User Name", buttonTitle: ["Ok"], buttonStyle: [.default]) { [weak self] _ in }
            return false
        }else if (txtPassword.text ?? "").trimmingCharacters(in: .whitespaces).isEmpty {
            AppComponet().showAlert(controller: self, message: "Please Enter Password", buttonTitle: ["Ok"], buttonStyle: [.default]) { [weak self] _ in }
            return false
        }
        return true
    }
}
