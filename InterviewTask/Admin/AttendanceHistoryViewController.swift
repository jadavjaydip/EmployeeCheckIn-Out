//
//  AttendanceHistoryViewController.swift
//  InterviewTask
//
//  Created by j on 08/10/24.
//

import UIKit

class AttendanceHistoryViewController: UIViewController {

    @IBOutlet weak var tblAttendanceHistroy: UITableView!
    var employeeID: String = ""
    var attendanceData:[AttendanceHistoryModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Employee Attendance Record"
        tblAttendanceHistroy.register(UINib(nibName: "AttentdanceTableViewCell", bundle: nil), forCellReuseIdentifier: "AttentdanceTableViewCell")
        getEmployeeAttentdance()
    }
    
    func getEmployeeAttentdance() {
        var dic = [String:Any]()
        dic["employee_id"] = employeeID
        ActivityIndicatior.startIndicator(view: self.view)
        Networking.sharedInstance.request(params: dic, url: "https://tracewavetransparency.com/admin/attendance.php", methodType: "POST") { [weak self] (model:[AttendanceHistoryModel]?, message:String) in
            guard let self = self else { return }
            ActivityIndicatior.stopIndicator(view: self.view)
            if let model = model {
                self.attendanceData = model
                self.reloadTableView()
            }else {
                AppComponet().showAlert(controller: self, message: message, buttonTitle: ["Ok"], buttonStyle: [.default]) { _ in }
            }
        }
    }
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tblAttendanceHistroy.reloadData()
        }
    }

}
extension AttendanceHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attendanceData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttentdanceTableViewCell", for: indexPath) as! AttentdanceTableViewCell
        cell.setupData(attendanceData: attendanceData[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
