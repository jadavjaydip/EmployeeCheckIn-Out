//
//  EmployeeListTableViewCell.swift
//  InterviewTask
//
//  Created by j on 08/10/24.
//

import UIKit

class EmployeeListTableViewCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblemail: UILabel!
    @IBOutlet weak var lblnumber: UILabel!
    @IBOutlet weak var lblemployeeid: UILabel!
    @IBOutlet weak var lbljoiningdate: UILabel!
    @IBOutlet weak var lbldepartment: UILabel!
    @IBOutlet weak var lblpassword: UILabel!
    @IBOutlet weak var lblsalarymonthly: UILabel!
    @IBOutlet weak var lbldesignation: UILabel!
    @IBOutlet weak var lblseniorname: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    func setupData(data: EmployeeModel?) {
        if let data = data {
            lblName.text = data.name
            lblemail.text = data.email
            lblnumber.text = data.number
            lblemployeeid.text = data.employeeID
            lbljoiningdate.text = data.joiningDate
            lbldepartment.text = data.department
            lblpassword.text = data.password
            lblsalarymonthly.text = data.salaryMonthly
            lblseniorname.text = data.seniorName
            lbldesignation.text = data.designation
        }
    }
}
