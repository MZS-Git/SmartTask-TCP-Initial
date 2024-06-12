import Foundation

class NetworkManager: AppDataSerializer {
    
    private override init() {}
    static let sharedInstance = NetworkManager()
    
    func callAPI<T: Codable>(endPoint: EndPoint, param: [String: Any]? = nil, ofType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        NetworkService.sharedInstance.getDataFromApi(endPoint: endPoint, param: param) { result in
            switch result {
            case .success(let data):
                print("Data From API Response :-> \(data)")
                self.parseData(data: data, ofType: ofType) { result in
                    switch result {
                    case .success(let result):
                        completion(.success(result))
                    case.failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case .failure(let error):
                switch error {
                case .dataError:
                    print("Data Error")
                case .badUrl:
                    print("BadUrl Error")
                case .serverError:
                    print("Server Error")
                }
            }
        }
    }
}
