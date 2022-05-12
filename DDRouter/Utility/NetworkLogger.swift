import Foundation

class NetworkLogger {
    static func log(request: URLRequest) {
        let urlString = request.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlString)

        let method = request.httpMethod ?? ""
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"

        var logOutput = """
        \(urlString) \n\n
        \(method) \(path)?\(query) HTTP/1.1 \n
        HOST: \(host)\n
        """
        for (key, value) in request.allHTTPHeaderFields ?? [:] {
            logOutput += "\(key): \(value)\n"
        }
        if let body = request.httpBody {
            logOutput += "\n \(String(data: body, encoding: .utf8) ?? "")"
        }

        print("\n - - - - - - - - - - OUTGOING - - - - - - - - - - \n")
        print(logOutput)
        print("\n - - - - - - - - - - - -  - - - - - - - - - - - - \n")
    }

    static func log(response: URLResponse) {
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Not HTTP response.")
            print("MIME-TYPE: \(response.mimeType ?? "nil")")
            return
        }

        var logOutput = "\(httpResponse.statusCode)\n\n"
        httpResponse.allHeaderFields.forEach { logOutput += "\($0): \($1)\n" }

        print("\n - - - - - - - - - - INCOMING - - - - - - - - - - \n")
        print(logOutput)
        print("\n - - - - - - - - - - - -  - - - - - - - - - - - - \n")
    }

    static func printJSONData(data: Data) {
        guard
            let object = try? JSONSerialization.jsonObject(
                with: data,
                options: []
            ),
            let prettyData = try? JSONSerialization.data(
                withJSONObject: object,
                options: [.prettyPrinted]
            ),
            let prettyPrintedString = String(
                data: prettyData,
                encoding: .utf8
            ) else {
            let rawString = String(data: data, encoding: .utf8) ?? ""
            print("----- Non-JSON Response\n\n\(rawString)")
            return
        }

        print(prettyPrintedString)
    }
}
