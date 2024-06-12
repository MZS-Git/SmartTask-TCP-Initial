import Foundation

enum GenericError: Error {
    case badUrl
    case serverError
    case dataError
}

class NetworkService: NSObject {
    
    private override init() {}
    static let sharedInstance = NetworkService()
    
    func getDataFromApi(endPoint: EndPoint, param: [String: Any]? = nil, completionHandler: @escaping(Result<Data, GenericError>) -> Void){
        
        guard let url = URL(string: AppEnviornment.Config.prodUrl + endPoint.url) else {
            return completionHandler(.failure(.badUrl))
        }
        print(url)
        
        var request = URLRequest(url: url)
        
        
        request.httpMethod = endPoint.method
        request.setValue("application/json", forHTTPHeaderField: AppEnviornment.HTTPHeaderField.contentType)
        request.setValue("application/json", forHTTPHeaderField: AppEnviornment.HTTPHeaderField.accept)
        request.setValue("Bearer \(AppEnviornment.Auth.bearerToken)", forHTTPHeaderField: AppEnviornment.HTTPHeaderField.authorization)
        
        URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            if error != nil  {
                completionHandler(.failure(.serverError))
            } else {
                if let data = data {
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print(jsonString)
                    }
                    completionHandler(.success(data))
                }
            }
        }.resume()
    }
}
