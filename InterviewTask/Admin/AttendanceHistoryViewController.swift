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
        tblAttendanceHistroy.register(UINib(nibName: "AttentdanceTableViewCell", bundle: nil), forCellReuseIdentifier: "AttentdanceTableViewCell")
        getEmployeeAttentdance()
    }
    
    func getEmployeeAttentdance() {
        var dic = [String:Any]()
        dic["employee_id"] = employeeID
        ActivityIndicatior.startIndicator(view: self.view)
        Networking.sharedInstance.request(params: dic, url: "https://tracewavetransparency.com/admin/attendance.php", methodType: "POST", model: [AttendanceHistoryModel].self, completionHandler: { [weak self] result in
            guard let self = self else { return }
            ActivityIndicatior.stopIndicator(view: self.view)
            switch result {
            case .success(let model):
                self.attendanceData = model
                self.reloadTableView()
            case .failure(let failure):
                AppComponet().showAlert(controller: self, message: failure.localizedDescription, buttonTitle: ["Ok"], buttonStyle: [.default]) { [weak self] _ in }
            }
        })
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
