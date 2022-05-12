import DDRouter
import Foundation

// MARK: - ResponseModel

struct ResponseModel: Decodable {
    let id: String
    let en: String
    let author: String
}

// MARK: - PostmanJSONModel

struct PostmanJSONModel: Decodable {
    let json: [String: String]?
    let url: URL
    let headers: HTTPHeaders
    let args: [String: String]
}

// MARK: - PostmanDataModel

struct PostmanDataModel: Decodable {
    let url: URL
    let data: String?
    let headers: HTTPHeaders
    let args: [String: String]
}

// MARK: - TestErrorModel

struct TestErrorModel: APIErrorModelProtocol {}

// MARK: - TestEndpoint

enum TestEndpoint {
    case randomQuote
    case postmanPost(data: Data)
}

// MARK: EndpointType

extension TestEndpoint: EndpointType {
    var baseURL: URL {
        switch self {
        case .randomQuote:
            // swiftlint:disable:next force_unwrapping
            return URL(string: "https://programming-quotes-api.herokuapp.com")!
        case .postmanPost:
            // swiftlint:disable:next force_unwrapping
            return URL(string: "https://postman-echo.com")!
        }
    }

    var path: String {
        switch self {
        case .randomQuote:
            return "quotes/random"
        case .postmanPost:
            return "post"
        }
    }

    var query: [String: String] {
        [:]
    }

    var method: HTTPMethod {
        switch self {
        case .randomQuote:
            return .get
        case .postmanPost:
            return .post
        }
    }

    var task: HTTPTask {
        switch self {
        case .randomQuote:
            return .request
        case let .postmanPost(data):
            return .requestWithRawBody(body: data)
        }
    }

    var headers: HTTPHeaders? {
        [:]
    }
}
