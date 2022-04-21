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
    /// HTTP Code 400
    case badRequest(APIErrorModel?)
    /// HTTP Code 401
    case unauthorized(APIErrorModel?)
    /// HTTP Code 403
    case forbidden(APIErrorModel?)
    /// HTTP Code 404
    case notFound
    /// HTTP Code 409
    case conflict(APIErrorModel?)
    /// HTTP Code 429
    case tooManyRequests

    // 5xx Server errors
    /// HTTP Code 500
    case serverError(APIErrorModel?)
    /// HTTP Code 503
    case serviceUnavailable

    // Network/connection errors
    case networkError // Low level network problems, e.g. can't connect, timeouts
    case insecureConnection // Thrown when NSURLSession detects security related network problems

    // Other errors
    case logoutError // Relogin failed, will be logged out directly

    // Unknown error
    case unknownError(APIErrorModel?) // Catch all
}
