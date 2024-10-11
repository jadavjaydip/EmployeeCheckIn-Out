//
//  AddEmployeesViewController.swift
//  InterviewTask
//
//  Created by j on 08/10/24.
//

import UIKit
import Photos

class AddEmployeesViewController: UIViewController {

    var departments: [String] = []
    let departmentPicker = UIPickerView()
    
    @IBOutlet weak var imgEmployee: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var txtEmployeeName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtnumber: UITextField!
    @IBOutlet weak var txtEmployeeId: UITextField!
    @IBOutlet weak var txtJoiningDate: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtSalary: UITextField!
    @IBOutlet weak var txtdesignation: UITextField!
    @IBOutlet weak var txtseniorname: UITextField!
    @IBOutlet weak var txtdepartment: UITextField!
    
    var imageData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Add Employee Data"
        fetchDepartments()
        imgEmployee.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openImagePicker(_ :))))
        txtdepartment.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openPickerView(_ :))))
        
    }
    @objc func openImagePicker(_ tapped: UITapGestureRecognizer) {
        PHPhotoLibrary.requestAuthorization { status in
            if status == .authorized {
                DispatchQueue.main.async {
                    self.showImagePicker()
                }
            } else {
                AppComponet().showAlert(controller: self, message: "Photo library access denied.", buttonTitle: ["OK"], buttonStyle: [.default]) { _ in}
            }
        }
    }
    
    private func showImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true // Allow image editing if needed
        present(imagePicker, animated: true, completion: nil)
    }
    @objc func openPickerView(_ tapped: UITapGestureRecognizer) {
        pickerView.isHidden = false
        pickerView.backgroundColor = .white
        txtdepartment.inputView = pickerView
        txtdepartment.becomeFirstResponder()
    }

    func fetchDepartments() {
        self.departments = ["Engineering", "Marketing", "HR"]
        departmentPicker.reloadAllComponents()
    }
    
    @IBAction func btnAddEmployee(_ sender: UIButton) {
        if validation() {
            var dic = [String: Any]()
            dic["name"] = txtEmployeeName.text ?? ""
            dic["email"] = txtEmail.text ?? ""
            dic["number"] = txtnumber.text ?? ""
            dic["employee_id"] = txtEmployeeId.text ?? ""
            dic["joining_date"] = txtJoiningDate.text ?? ""
            dic["department"] = txtdepartment.text ?? ""
            dic["password"] = txtPassword.text ?? ""
            dic["salary_monthly"] = txtSalary.text ?? ""
            dic["designation"] = txtdesignation.text ?? ""
            dic["senior_name"] = txtseniorname.text ?? ""
//            if let image = imgEmployee.image, let imageData = image.jpegData(compressionQuality: 0.7) {
//                let base64String = imageData.base64EncodedString()
//                dic["profile_photo"] = base64String
//            } else {
//                dic["profile_photo"] = "" // Handle the case where the image is not available
//            }
//           // dic["profile_photo"] = imgEmployee.image?.pngData()
            var dictFileParam = [String:Data]()
            if imageData != nil {
                dictFileParam["image"] = imgEmployee.image?.jpegData(compressionQuality: 0.8)
            }
            ActivityIndicatior.startIndicator(view: self.view)
            Networking.sharedInstance.request(params: dic, fileParams: dictFileParam,url: "https://tracewavetransparency.com/admin/add_employee.php", methodType: "POST") { [weak self ] (model:EmployeeModel?, message:String) in
                guard let self = self else {return}
                ActivityIndicatior.stopIndicator(view: self.view)
                if model != nil {
                    AppComponet().showAlert(controller: self, message: "Successfull data added", buttonTitle: ["Ok"], buttonStyle: [.default]) { _ in
                        self.navigationController?.popViewController(animated: true)
                    }
                }else {
                    AppComponet().showAlert(controller: self, message: message, buttonTitle: ["Ok"], buttonStyle: [.default]) {  _ in }
                }
            }
        }
    }
    
    func validation() -> Bool {
        if (txtEmployeeName.text ?? "").trimmingCharacters(in: .whitespaces).isEmpty {
            AppComponet().showAlert(controller: self, message: "Please Enter Name", buttonTitle: ["Ok"], buttonStyle: [.default]) {  _ in }
            return false
        }else if (txtEmail.text ?? "").trimmingCharacters(in: .whitespaces).isEmpty {
            AppComponet().showAlert(controller: self, message: "Please Enter Email", buttonTitle: ["Ok"], buttonStyle: [.default]) {  _ in }
            return false
        }
        else if (txtnumber.text ?? "").trimmingCharacters(in: .whitespaces).isEmpty {
            AppComponet().showAlert(controller: self, message: "Please Enter Number", buttonTitle: ["Ok"], buttonStyle: [.default]) {  _ in }
            return false
        }
        else if (txtEmployeeId.text ?? "").trimmingCharacters(in: .whitespaces).isEmpty {
            AppComponet().showAlert(controller: self, message: "Please Enter Employee ID", buttonTitle: ["Ok"], buttonStyle: [.default]) {  _ in }
            return false
        }
        else if (txtJoiningDate.text ?? "").trimmingCharacters(in: .whitespaces).isEmpty {
            AppComponet().showAlert(controller: self, message: "Please Enter Joining Date", buttonTitle: ["Ok"], buttonStyle: [.default]) {  _ in }
            return false
        }
        else if (txtdepartment.text ?? "").trimmingCharacters(in: .whitespaces).isEmpty {
            AppComponet().showAlert(controller: self, message: "Please Enter Department", buttonTitle: ["Ok"], buttonStyle: [.default]) {  _ in }
            return false
        }
        else if (txtPassword.text ?? "").trimmingCharacters(in: .whitespaces).isEmpty {
            AppComponet().showAlert(controller: self, message: "Please Enter Password", buttonTitle: ["Ok"], buttonStyle: [.default]) {  _ in }
            return false
        }
        else if (txtSalary.text ?? "").trimmingCharacters(in: .whitespaces).isEmpty {
            AppComponet().showAlert(controller: self, message: "Please Enter Salary", buttonTitle: ["Ok"], buttonStyle: [.default]) {  _ in }
            return false
        }
        else if (txtdesignation.text ?? "").trimmingCharacters(in: .whitespaces).isEmpty {
            AppComponet().showAlert(controller: self, message: "Please Enter Designation", buttonTitle: ["Ok"], buttonStyle: [.default]) { _ in }
            return false
        }
        else if (txtseniorname.text ?? "").trimmingCharacters(in: .whitespaces).isEmpty {
            AppComponet().showAlert(controller: self, message: "Please Enter Senior Name", buttonTitle: ["Ok"], buttonStyle: [.default]) {  _ in }
            return false
        }
        
        return true
    }
}

extension AddEmployeesViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    // MARK: - UIPickerView Delegate and DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return departments.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return departments[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtdepartment.text = departments[row]
        pickerView.isHidden = true
        txtdepartment.resignFirstResponder()
    }
}

extension AddEmployeesViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
}

extension AddEmployeesViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let editedImage = info[.editedImage] as? UIImage {
                imageData = editedImage.pngData()
                imgEmployee.image = editedImage
            } else if let originalImage = info[.originalImage] as? UIImage {
                imageData = originalImage.pngData()
                imgEmployee.image = originalImage
            }
            dismiss(animated: true, completion: nil)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
}
