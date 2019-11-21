//
//  Service.swift
//  Webboard
//
//  Created by Suriya on 27/10/2562 BE.
//  Copyright © 2562 Arthit Thongpan. All rights reserved.
//

import Alamofire

class Service {
    static let END_POINT = "http://localhost:8080"
    
    static let LOGIN_API = "\(END_POINT)/api/v1.0/login"
    static let REGISTER_API = "\(END_POINT)/api/v1.0/register"
    
    // Post & Comment
    static let GET_ALL_POSTS_API = "\(END_POINT)/api/v1.0/posts/"
    
    let httpClient: HttpClient
    
    init(client: HttpClient = HttpClient()) {
        httpClient = client
    }
    
    func login(username: String, password: String, completionHandler: @escaping(ApiResult<LoginResponse>) -> Void) {
        let credentiaData = "\(username):\(password)".data(using: .utf8)
        guard let base64Credentials = credentiaData?.base64EncodedString(options: []) else {
            return
        }
        
        let customHeader = ["Authorization": "Basic \(base64Credentials)"]
        
        httpClient.request(Service.LOGIN_API, method: .post, parameter: nil, customHeaders: customHeader) { result in
            
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                
                do {
                    let response = try decoder.decode(LoginResponse.self, from: data as! Data)
                    completionHandler(.success(response))
                } catch {
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getAllPost(completionHandler: @escaping(ApiResult<[Post]>) -> Void) {
        httpClient.request(Service.GET_ALL_POSTS_API, method: .get, parameter: nil) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                
                do {
                    let response = try decoder.decode([Post].self, from: data as! Data)
                    completionHandler(.success(response))
                } catch {
                    completionHandler(.failure(error))
                }
            case  .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
