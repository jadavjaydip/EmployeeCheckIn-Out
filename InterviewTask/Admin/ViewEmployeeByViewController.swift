//
//  ViewEmployeeByViewController.swift
//  InterviewTask
//
//  Created by j on 08/10/24.
//

import UIKit

class ViewEmployeeByViewController: UIViewController {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lblEmployeeId: UILabel!
    @IBOutlet weak var lblJoiningDate: UILabel!
    @IBOutlet weak var lbldepartment: UILabel!
    @IBOutlet weak var lblpassword: UILabel!
    @IBOutlet weak var lblSalary: UILabel!
    @IBOutlet weak var lbldesignation: UILabel!
    @IBOutlet weak var lblseniorname: UILabel!
   
  
    var employee: EmployeeModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Employee Details"
        setupData()
        //getEmplyeeDetails()
    }
//    func getEmplyeeDetails() {
//        var dic = [String:Any]()
//        dic["employee_id"] = employee?.employeeID ?? ""
//        Networking.sharedInstance.request(params: dic, url: "https://tracewavetransparency.com/admin/get_employee_details.php", methodType: "POST", model: EmployeeModel.self) { result  in
//            switch result {
//            case .success(let model):
//                break
//                //self.setupData(employee: model)
//            case .failure(let failure):
//                print(failure)
//            }
//        }
//    }
    
    func setupData() {
        if let employee = employee {
            lblName.text = employee.name
            lblEmail.text = employee.email
            lblNumber.text = employee.number
            lblEmployeeId.text = employee.employeeID
            lblJoiningDate.text = employee.joiningDate
            lbldepartment.text = employee.department
            lblpassword.text = employee.password
            lblseniorname.text = employee.seniorName
            lblSalary.text = employee.salaryMonthly
            lbldesignation.text = employee.designation
        }
    }
    
    @IBAction func btnAttentdance(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AttendanceHistoryViewController") as! AttendanceHistoryViewController
        vc.employeeID = employee?.employeeID ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
