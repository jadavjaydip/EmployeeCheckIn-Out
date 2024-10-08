//
//  SelectRoleViewController.swift
//  InterviewTask
//
//  Created by j on 08/10/24.
//

import UIKit

class SelectRoleViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    @IBAction func btnAdmin(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AdminLoginViewController") as! AdminLoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnEmployee(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EmployeeLoginViewController") as! EmployeeLoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
