//
//  EmployeeLoginViewController.swift
//  InterviewTask
//
//  Created by j on 08/10/24.
//

import UIKit

class EmployeeLoginViewController: UIViewController {

    @IBOutlet weak var txtEmployeeName: UITextField!
    @IBOutlet weak var txtEmployeePassword: UITextField!
    var employeeData: EmployeeModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    func loginEMployee() {
        var dic = [String:Any]()
        dic["employee_id"] = txtEmployeeName.text ?? ""
        dic["password"] = txtEmployeePassword.text ?? ""
        ActivityIndicatior.startIndicator(view: self.view)
        Networking.sharedInstance.request(params: dic, url: "https://tracewavetransparency.com/admin/login.php", methodType: "POST", model: EmployeeModel.self) { [weak self] result in
            guard let self = self else { return }
            ActivityIndicatior.stopIndicator(view: self.view)
            switch result {
            case .success(let model):
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EmployeeProfileViewController") as! EmployeeProfileViewController
                vc.employeeData = model
                self.navigationController?.pushViewController(vc, animated: true)
            case .failure(let failure):
                AppComponet().showAlert(controller: self, message: failure.localizedDescription, buttonTitle: ["Ok"], buttonStyle: [.default]) { [weak self] _ in }
            }
        }
    }

    @IBAction func btnLogin(_ sender: UIButton) {
        if validation() {
            loginEMployee()
        }
    }
    func validation() -> Bool {
        if (txtEmployeeName.text ?? "").trimmingCharacters(in: .whitespaces).isEmpty {
            AppComponet().showAlert(controller: self, message: "Please Enter Employee ID", buttonTitle: ["Ok"], buttonStyle: [.default]) { [weak self] _ in }
            return false
        }else if (txtEmployeePassword.text ?? "").trimmingCharacters(in: .whitespaces).isEmpty {
            AppComponet().showAlert(controller: self, message: "Please Enter Password", buttonTitle: ["Ok"], buttonStyle: [.default]) { [weak self] _ in }
            return false
        }
        return true
    }
}


