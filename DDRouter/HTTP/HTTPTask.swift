import Foundation

public typealias HTTPHeaders = [String: String]

// MARK: - HTTPTask

// TODO: this is probably not necessary - can replace with something less intrusive
public enum HTTPTask {
    case request
    case requestWithBody(body: Encodable)
    case requestWithRawBody(body: Data)

    @available(*, deprecated, renamed: "requestWithBody")
    case requestEncodableParameters(
        bodyParameters: Encodable?,
        urlParameters: Parameters?
    )

    // case download, upload...etc

    // this is where multipart requests will be in future
}
