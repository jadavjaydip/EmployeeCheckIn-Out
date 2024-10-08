//
//  AdminDashboardViewController.swift
//  InterviewTask
//
//  Created by j on 08/10/24.
//

import UIKit

class AdminDashboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tblEmployeeList: UITableView!
    var employees: [EmployeeModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let btnName = UIButton(type: .custom)
        btnName.setImage(UIImage(systemName: "plus"), for: .normal)
        btnName.frame = CGRectMake(0, 0, 30, 30)
        btnName.addTarget(self, action: #selector(addEmplyeeData(_ :)), for: .touchUpInside)

        //.... Set Right/Left Bar Button item
        let rightBarButton = UIBarButtonItem()
        rightBarButton.customView = btnName
        self.navigationItem.rightBarButtonItem = rightBarButton
        tblEmployeeList.register(UINib(nibName: "EmployeeListTableViewCell", bundle: nil), forCellReuseIdentifier: "EmployeeListTableViewCell")
        fetchEmployees()
        
       
    }

    @objc func addEmplyeeData(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddEmployeesViewController") as! AddEmployeesViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func fetchEmployees() {
        ActivityIndicatior.startIndicator(view: self.view)
        Networking.sharedInstance.request(params: [String : Any](), url: "https://tracewavetransparency.com/admin/get_employees.php", methodType: "GET", model: [EmployeeModel].self) { [weak self] result in
            guard let self = self else {return}
            ActivityIndicatior.stopIndicator(view: self.view)
            switch result {
            case .success(let model):
                self.employees = model
                reloadTableView()
            case .failure(let failure):
                AppComponet().showAlert(controller: self, message: failure.localizedDescription, buttonTitle: ["Ok"], buttonStyle: [.default]) { [weak self] _ in }
            }
        }
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tblEmployeeList.reloadData()
        }
    }

    // MARK: - UITableView DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeListTableViewCell", for: indexPath) as! EmployeeListTableViewCell
        let employee = employees[indexPath.row]
        cell.setupData(data: employee)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewEmployeeByViewController") as! ViewEmployeeByViewController
        print(employees[indexPath.row])
        vc.employee = employees[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
