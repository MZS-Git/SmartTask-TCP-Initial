import Foundation

protocol AppDataSerializerProtocol {
    
    func parseData<T: Codable>(data: Data, ofType: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

class AppDataSerializer: AppDataSerializerProtocol {
    
    func parseData<T: Codable>(data: Data, ofType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        do{
            let result = try JSONDecoder().decode(ofType, from: data)
            completion(.success(result))
        }
        catch {
            completion(.failure(error))
        }
    }
}
