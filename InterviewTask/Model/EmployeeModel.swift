//
//  EmployeeModel.swift
//  InterviewTask
//
//  Created by j on 08/10/24.
//

import Foundation
import SwiftyJSON
struct EmployeeModel:Codable {
    var id: Int = 0
    var name: String = ""
    var email: String = ""
    var number: String = ""
    var employeeID: String = ""
    var joiningDate = ""
    var department = ""
    var password = ""
    var salaryMonthly: String = ""
    var designation = ""
    var seniorName = ""
    var profilePhoto: String = ""
    
    enum CodingKeys: String, CodingKey {
            case id, name, email, number
            case employeeID = "employee_id"
            case joiningDate = "joining_date"
            case department, password
            case salaryMonthly = "salary_monthly"
            case designation
            case seniorName = "senior_name"
            case profilePhoto = "profile_photo"
        }
    
    init() {
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = values.getIntValue(key: CodingKeys.id) ?? 0
        self.name = values.getStringValue(key: CodingKeys.name) ?? ""
        self.email = values.getStringValue(key: CodingKeys.email) ?? ""
        self.number = values.getStringValue(key: CodingKeys.number) ?? ""
        self.employeeID = values.getStringValue(key: CodingKeys.employeeID) ?? ""
        self.joiningDate = values.getStringValue(key: CodingKeys.joiningDate) ?? ""
        self.department = values.getStringValue(key: CodingKeys.department) ?? ""
        self.password = values.getStringValue(key: CodingKeys.password) ?? ""
        self.salaryMonthly = values.getStringValue(key: CodingKeys.salaryMonthly) ?? ""
        self.designation = values.getStringValue(key: CodingKeys.designation) ?? ""
        self.seniorName = values.getStringValue(key: CodingKeys.seniorName) ?? ""
        self.profilePhoto = values.getStringValue(key: CodingKeys.profilePhoto) ?? ""
    }
}

struct AttendanceHistoryModel:Codable {
    var id: Int = 0
    var employeeID: String = ""
    var date: String = ""
    var totalhours: String  = ""
    var checkintime: String  = ""
    var checkouttime: String = ""
     
    enum CodingKeys: String, CodingKey {
        case id
        case employeeID = "employee_id"
        case date
        case totalhours = "total_hours"
        case checkintime = "check_in_time"
        case  checkouttime = "check_out_time"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = values.getIntValue(key: CodingKeys.id) ?? 0
        self.employeeID = values.getStringValue(key: CodingKeys.employeeID) ?? ""
        self.date = values.getStringValue(key: CodingKeys.date) ?? ""
        self.totalhours = values.getStringValue(key: CodingKeys.totalhours) ?? ""
        self.checkintime = values.getStringValue(key: CodingKeys.checkintime) ?? ""
        self.checkouttime = values.getStringValue(key: CodingKeys.checkouttime) ?? ""
    }
}

struct GanralModel: Codable {
    var status: String
    var message: String
}


extension KeyedDecodingContainer{
    func getStringValue(key:CodingKey)->String?{
        if let value = try? self.decodeIfPresent(Bool.self, forKey: key as! K){
            return value ? "true" : "false"
        }else if let value = try? self.decodeIfPresent(String.self, forKey: key as! K){
            return value
        }else if let value = try? self.decodeIfPresent(Int.self, forKey: key as! K){
            return "\(value)"
        }else if let value = try? self.decodeIfPresent(Double.self, forKey: key as! K){
            return "\(value)"
        }
        return nil
    }
    
    func getIntValue(key:CodingKey)->Int?{
        if let value = try? self.decodeIfPresent(Int.self, forKey: key as! K){
            return value
        }else if let value = try? self.decodeIfPresent(String.self, forKey: key as! K){
            return Int(value)
        }else if let value = try? self.decodeIfPresent(Double.self, forKey: key as! K){
            return Int(value)
        }else if let value = try? self.decodeIfPresent(Bool.self, forKey: key as! K){
            return value ? 1 : 0
        }
        return nil
    }}
