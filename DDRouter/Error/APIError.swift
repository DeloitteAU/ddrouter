import Foundation

// MARK: - APIErrorModelProtocol

// implement this protocol and pass implementation type as generic
// parameter to the router and APIError types
public protocol APIErrorModelProtocol: Decodable {}

// MARK: - APIError

// TODO: change this to correspond to normal status codes

/// An error type usedor http
public enum APIError<APIErrorModel: APIErrorModelProtocol>: Error {
    // General (internal) errors
    case serializeError(Error?)
    case internalError
    case nullData
    // 4xx Client errors
    case badRequest(APIErrorModel?)
    case unauthorized(APIErrorModel?)
    case forbidden(APIErrorModel?)
    case notFound
    case tooManyRequests

    // 5xx Server errors
    case serverError(APIErrorModel?) // 500
    case serviceUnavailable // 503

    // Network/connection errors
    case networkError // Low level network problems, e.g. can't connect, timeouts
    case insecureConnection // Thrown when NSURLSession detects security related network problems

    // Other errors
    case logoutError // Relogin failed, will be logged out directly

    // Unknown error
    case unknownError(APIErrorModel?) // Catch all
}
