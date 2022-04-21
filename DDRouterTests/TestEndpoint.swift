import DDRouter
import Foundation

// MARK: - ResponseModel

struct ResponseModel: Decodable {
    let _id: String
    let en: String
    let author: String
}

// MARK: - TestEndpoint

enum TestEndpoint {
    case random
}

// MARK: EndpointType

extension TestEndpoint: EndpointType {
    var baseURL: URL {
        URL(string: "https://programming-quotes-api.herokuapp.com")!
    }

    var path: String {
        switch self {
        case .random:
            return "/quotes/random"
        }
    }

    var query: [String: String] {
        [:]
    }

    var method: HTTPMethod {
        switch self {
        case .random:
            return .get
        }
    }

    var task: HTTPTask {
        switch self {
        case .random:
            return .request
        }
    }

    var headers: HTTPHeaders? {
        [:]
    }
}
