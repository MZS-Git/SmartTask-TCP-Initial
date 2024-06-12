import Foundation

struct AppEnviornment {
        
    struct Config {
        static let stageUrl = "http://demo1414406"
        static let prodUrl = "http://demo1414406"
    }
    
    struct Auth {
        static let bearerToken = "Bearer Token"
    }
    
    struct HTTPHeaderField {
        static let authorization = "Authorization"
        static let contentType = "Content-Type"
        static let accept = "Accept"
    }
}
