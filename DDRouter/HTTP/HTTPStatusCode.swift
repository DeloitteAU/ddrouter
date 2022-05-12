import Foundation

// TODO: should be all the status codes!
/** An enumeration of all HTTP status codes and their corresponding descriptions.
 */
enum HTTPStatusCode: Int {
    // 2xx Success
    case ok = 200

    // 4xx Client error
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case conflict = 409
    case tooManyRequests = 429

    // 5xx Server error
    case serverError = 500
    case serviceUnavailable = 503
}
