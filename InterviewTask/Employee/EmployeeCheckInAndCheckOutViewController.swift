//
//  EmployeeCheckInAndCheckOutViewController.swift
//  InterviewTask
//
//  Created by j on 08/10/24.
//

import UIKit

class EmployeeCheckInAndCheckOutViewController: UIViewController {

    @IBOutlet weak var txtCheckInTime: UITextField!
    @IBOutlet weak var txtCheckInDate: UITextField!
    
    @IBOutlet weak var txtCheckOutTime: UITextField!
    @IBOutlet weak var txtCheckOutDate: UITextField!
    
    var employeeData: EmployeeModel?
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func btnCheckIn(_ sender: UIButton) {
        if checkInValidation() {
            checkInAPICall()
        }
    }
    
    @IBAction func btnCheckOut(_ sender: UIButton) {
        if checkOutValidation() {
            checkOutAPICall()
        }
    }
    
    func checkInAPICall() {
        var dic = [String:Any]()
        dic["date"] = txtCheckInDate.text ?? ""
        dic["check_in_time"] = txtCheckInTime.text ?? ""
        dic["employee_id"] = employeeData?.employeeID ?? ""
        ActivityIndicatior.startIndicator(view: self.view)
        Networking.sharedInstance.request(params: dic, url: "https://tracewavetransparency.com/admin/checkin.php", methodType: "POST", model: GanralModel.self) { [weak self] result in
            guard let self = self else { return }
            ActivityIndicatior.stopIndicator(view: self.view)
            switch result {
            case .success(let success):
                AppComponet().showAlert(controller: self,title: "success", message: "Check-in successful", buttonTitle: ["Ok"], buttonStyle: [.default]) { [weak self] _ in }
            case .failure(let failure):
                AppComponet().showAlert(controller: self, message: failure.localizedDescription, buttonTitle: ["Ok"], buttonStyle: [.default]) { [weak self] _ in }
            }
        }
    }
    
    func checkOutAPICall() {
        var dic = [String:Any]()
        dic["date"] = txtCheckOutDate.text ?? ""
        dic["check_out_time"] = txtCheckOutTime.text ?? ""
        dic["employee_id"] = employeeData?.employeeID ?? ""
        dic["total_hours"] = ""
        ActivityIndicatior.startIndicator(view: self.view)
        Networking.sharedInstance.request(params: dic, url: "https://tracewavetransparency.com/admin/checkout.php", methodType: "POST", model: GanralModel.self) { [weak self] result in
            guard let self = self else { return }
            ActivityIndicatior.stopIndicator(view: self.view)
            switch result {
            case .success(let success):
                AppComponet().showAlert(controller: self,title: "success", message: "Check-out successful", buttonTitle: ["Ok"], buttonStyle: [.default]) { [weak self] _ in }
            case .failure(let failure):
                AppComponet().showAlert(controller: self, message: failure.localizedDescription, buttonTitle: ["Ok"], buttonStyle: [.default]) { [weak self] _ in }
            }
        }
    }
    
    func checkInValidation() -> Bool {
        if (txtCheckInDate.text ?? "").trimmingCharacters(in: .whitespaces).isEmpty {
            AppComponet().showAlert(controller: self, message: "Please Enter check in date", buttonTitle: ["Ok"], buttonStyle: [.default]) { [weak self] _ in }
            return false
        }else if (txtCheckInTime.text ?? "").trimmingCharacters(in: .whitespaces).isEmpty {
            AppComponet().showAlert(controller: self, message: "Please Enter check in time", buttonTitle: ["Ok"], buttonStyle: [.default]) { [weak self] _ in }
            return false
        }
        return true
    }
    
    func checkOutValidation() -> Bool {
        if (txtCheckOutDate.text ?? "").trimmingCharacters(in: .whitespaces).isEmpty {
            AppComponet().showAlert(controller: self, message: "Please Enter check out date", buttonTitle: ["Ok"], buttonStyle: [.default]) { [weak self] _ in }
            return false
        }else if (txtCheckOutTime.text ?? "").trimmingCharacters(in: .whitespaces).isEmpty {
            AppComponet().showAlert(controller: self, message: "Please Enter check out time", buttonTitle: ["Ok"], buttonStyle: [.default]) { [weak self] _ in }
            return false
        }
        return true
    }
}
