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
    let boundary = UUID().uuidString
    func request<T: Codable>(params: [String: Any],fileParams: [String:Data]? = nil, url: String, methodType: String,completionHandler: @escaping(_ model:T?, _ message: String) -> ()) {
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
        
        if fileParams != nil {
            urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
                 // Create the body data
            let bodyData = createBody(with: params, filePathKey: "profile_photo", imageDataKey:  fileParams?["image"] ?? Data(), boundary: boundary)
            urlRequest.httpBody = bodyData
        }
        print("Request Param", params)

        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completionHandler(nil, error!.localizedDescription)
                return
            }
            
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
                                completionHandler(model, "")
                            }else if  let dic = jsonData as? NSDictionary, let data = dic["employee"]{
                                print(data)
                                 let datas = try JSONSerialization.data(withJSONObject: data, options: [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes])
                                 let model = try JSONDecoder().decode(T.self, from: datas)
                                 print(model)
                                completionHandler(model, "")
                            }else {
                                let model = try JSONDecoder().decode(T.self, from: data)
                                   print(model)
                                completionHandler(model, "")
                            }
                        }else {
                            if let dic = jsonData as? NSDictionary, let status = dic["status"] as? String, status == "error" {
                                completionHandler(nil, dic["message"] as! String)
                            }
                        }
                    }catch {
                        completionHandler(nil, error.localizedDescription)
                        print(error.localizedDescription)
                    }
                }
            }
        }.resume()
    }
    
// Helper function to create the body data for multipart request
func createBody(with parameters: [String: Any], filePathKey: String, imageDataKey: Data, boundary: String) -> Data {
    var body = Data()

    let boundaryPrefix = "--\(boundary)\r\n"

    // Add parameters to body
    for (key, value) in parameters {
        body.append(Data("\(boundaryPrefix)".utf8))
        body.append(Data("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".utf8))
        body.append(Data("\(value)\r\n".utf8))
    }

    // Add image data to body
    let filename = "profile_photo.jpg"
    let mimetype = "image/jpg"

    body.append(Data("\(boundaryPrefix)".utf8))
    body.append(Data("Content-Disposition: form-data; name=\"\(filePathKey)\"; filename=\"\(filename)\"\r\n".utf8))
    body.append(Data("Content-Type: \(mimetype)\r\n\r\n".utf8))
    body.append(imageDataKey)
    body.append(Data("\r\n".utf8))

    // End the request with the boundary
    body.append(Data("--\(boundary)--\r\n".utf8))

    return body
}

    
//    private func createBody(with parameters: [String: Any], fileParams: [String: Data]?) -> Data {
//            var body = Data()
//            
//            for (key, value) in parameters {
//                body.append("--\(boundary)\r\n".data(using: .utf8)!)
//                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
//                body.append("\(value)\r\n".data(using: .utf8)!)
//            }
//            
//            if let fileParams = fileParams {
//                for (key, data) in fileParams {
//                    body.append("--\(boundary)\r\n".data(using: .utf8)!)
//                    body.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(key).jpg\"\r\n".data(using: .utf8)!) // Change the file extension if needed
//                    body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
//                    body.append(data)
//                    body.append("\r\n".data(using: .utf8)!)
//                }
//            }
//            
//            body.append("--\(boundary)--\r\n".data(using: .utf8)!)
//            
//            return body
//        }
}
