//
//  EmployeeProfileViewController.swift
//  InterviewTask
//
//  Created by j on 08/10/24.
//

import UIKit
import SDWebImage

class EmployeeProfileViewController: UIViewController {

    @IBOutlet weak var imgEmployee: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lblEmployeeId: UILabel!
    @IBOutlet weak var lblJoiningDate: UILabel!
    @IBOutlet weak var lbldepartment: UILabel!
    @IBOutlet weak var lblpassword: UILabel!
    @IBOutlet weak var lblSalary: UILabel!
    @IBOutlet weak var lbldesignation: UILabel!
    @IBOutlet weak var lblSeniorname: UILabel!
    
    var employeeData: EmployeeModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Employee Profile"
        let btnName = UIButton(type: .custom)
        btnName.setImage(UIImage(systemName: "list.bullet.circle.fill"), for: .normal)
        btnName.frame = CGRectMake(0, 0, 30, 30)
        btnName.addTarget(self, action: #selector(checkInOut(_ :)), for: .touchUpInside)

        let rightBarButton = UIBarButtonItem()
        rightBarButton.customView = btnName
        self.navigationItem.rightBarButtonItem = rightBarButton
        setupData()
    }
    
    @objc func checkInOut(_ sender: UIButton){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EmployeeCheckInAndCheckOutViewController") as!EmployeeCheckInAndCheckOutViewController
        vc.employeeData = employeeData
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func setupData() {
        if let employee = employeeData {
            lblName.text = employee.name
            lblEmail.text = employee.email
            lblNumber.text = employee.number
            lblEmployeeId.text = employee.employeeID
            lblJoiningDate.text = employee.joiningDate
            lbldepartment.text = employee.department
            lblpassword.text = employee.password
            lblSeniorname.text = employee.seniorName
            lblSalary.text = employee.salaryMonthly
            lbldesignation.text = employee.designation
            let url = "https://tracewavetransparency.com/admin/" + "\(employee.profilePhoto)"
            imgEmployee.sd_setImage(with: URL(string: url), placeholderImage: UIImage(systemName: "User"))
        }
    }
}
