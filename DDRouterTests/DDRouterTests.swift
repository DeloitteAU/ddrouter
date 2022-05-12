@testable import DDRouter
import RxBlocking
import RxTest
import XCTest

class DDRouterTests: XCTestCase {
    var router: Router<TestEndpoint, TestErrorModel>?

    override func setUp() {
        DDRouter.initialise(
            configuration: URLSessionConfiguration.default,
            printToConsole: false
        )
        router = Router<TestEndpoint, TestErrorModel>()
    }

    override func tearDown() {
        router = nil
        DDRouter.sharedSession = nil
    }

    // TODO: tests for all the failure cases
    func testSuccess() {
        guard let response: ResponseModel = try? router?.request(.randomQuote)
            .toBlocking()
            .first() else {
            XCTFail("Test failed")
            return
        }

        XCTAssert(!response.author.isEmpty)
        XCTAssert(!response.en.isEmpty)
    }

    func testRawData() throws {
        let data: Data = try XCTUnwrap("A raw string".data(using: .utf8))
        guard let response: PostmanDataModel = try? router?.request(.postmanPost(data: data))
            .toBlocking()
            .first() else {
            XCTFail("Test failed")
            return
        }

        XCTAssertEqual(response.data, "A raw string")
    }

    func testRawJSON() throws {
        let data: Data = try XCTUnwrap("""
        {
        "foo": "bar",
        "dog": "7"
        }
        """.data(using: .utf8))
        guard let response: PostmanJSONModel = try? router?.request(.postmanPost(data: data))
            .toBlocking()
            .first() else {
            XCTFail("Test failed")
            return
        }

        let jsonResponse = try XCTUnwrap(response.json)
        XCTAssertEqual(jsonResponse["foo"], "bar")
        XCTAssertEqual(jsonResponse["dog"], "7")
    }
}
