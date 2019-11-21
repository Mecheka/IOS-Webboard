
import Foundation
import Alamofire

enum ApiResult<Value> {
    case success(Value)
    case failure(Error)
}

class HttpClient {

    func request(_ url: URLConvertible, method: HTTPMethod, parameter: Parameters?, customHeaders: [String: String] = [:], encodeing: ParameterEncoding = JSONEncoding.default, multipart: Bool = false, completionHandler: @escaping(ApiResult<Any?>) -> Void){
        
        var header = [
            "Language": "th",
            "Platform": UIDevice.current.systemVersion,
            "IOS": UIDevice.current.systemVersion,
            "Content-Type": "application/json; charset=utf-8",
            "App-Version": Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        ]
        
        if let token = AuthorizationManager.shared.token {
            header["Authorization"] = "Bearer \(token)"
        }
        
        header.merge(customHeaders){(_, new) in new}
        
        print("Header: \(header)")
        print("Request[\(method)]: \(url) [\(String(describing: parameter))]")
        
        if multipart {
            // TODO: Upload image
        } else {
            Alamofire.request(url, method: method, parameters: parameter, encoding: encodeing, headers: header)
                .validate()
                .responseJSON { response in
                    print("response.request: \(String(describing: response.request))")
                    print("response.response: \(String(describing: response.response))")
                    print("response.result: \(response.result)")
                    print("response.result.value: \(String(describing: response.result.value))")
                    
                    switch response.result {
                    case .success:
                        completionHandler(.success(response.data))
                    case .failure(let error):
                        print("status code: \(String(describing: response.response?.statusCode))")
                        print(error.localizedDescription)
                        
                        guard let statusCode = response.response?.statusCode else {
                            completionHandler(.failure(error))
                            return
                        }
                        
                        switch statusCode {
                        case 200:
                            completionHandler(.success(nil))
                        case 401:
                            completionHandler(.failure(error))
                        default:
                            completionHandler(.failure(error))
                        }
                    }
            }
        }
    }
}
