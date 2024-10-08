//
//  Networking.swift
//  InterviewTask
//
//  Created by j on 08/10/24.
//

import Foundation
enum ErrorMessage: Error {
    case errorMessage(String)
}
class Networking {
    static let sharedInstance: Networking = Networking()
    private init () {}
    
    func request<T: Codable>(params: [String: Any], url: String, methodType: String, model: T.Type,completionHandler: @escaping(Result<T,Error>) -> ()) {
        var strURL = url
        if methodType == "GET" {
            if params.count > 0 {
                let jsonString = params.reduce("") { "\($0)\($1.0)=\($1.1)&".dropLast()}
                strURL = "\(strURL)?\(jsonString)"
            }
        }
        
        var urlRequest: URLRequest!
        urlRequest = URLRequest(url:  URL(string: strURL)!, timeoutInterval: 60)
        urlRequest.httpMethod = methodType

        
       

        if methodType != "GET" {
            urlRequest.httpBody = params.percentEscaped().data(using: .utf8)
        }
        
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completionHandler(.failure(error!))
                return
            }
            
            print("data", params)
            if let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data {
                DispatchQueue.main.async {
                    do {
                        let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                        if let dic = jsonData as? NSDictionary, let status = dic["status"] as? String, status == "success" {
                            if let dic = jsonData as? NSDictionary, let data = dic["data"]{
                               print(data)
                                let datas = try JSONSerialization.data(withJSONObject: data, options: [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes])
                                let model = try JSONDecoder().decode(T.self, from: datas)
                               print(model)
                                completionHandler(.success(model))
                            }else if  let dic = jsonData as? NSDictionary, let data = dic["employee"]{
                                print(data)
                                 let datas = try JSONSerialization.data(withJSONObject: data, options: [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes])
                                 let model = try JSONDecoder().decode(T.self, from: datas)
                                 print(model)
                                 completionHandler(.success(model))
                            }else {
                                let model = try JSONDecoder().decode(T.self, from: data)
                                   print(model)
                                   completionHandler(.success(model))
                            }
                        }else {
                            if let dic = jsonData as? NSDictionary, let status = dic["status"] as? String, status == "error" {
                                completionHandler(.failure(ErrorMessage.errorMessage(dic["message"] as! String)))
                            }
                        }
                    }catch {
                        completionHandler(.failure(error))
                        print(error.localizedDescription)
                    }
                }
            }
        }.resume()
    }
}




extension Dictionary {
    func percentEscaped() -> String {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
