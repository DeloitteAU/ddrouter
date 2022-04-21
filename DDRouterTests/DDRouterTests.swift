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
        guard let response: ResponseModel = try? router?.request(.random)
            .toBlocking()
            .first() else {
            XCTFail()
            return
        }

        XCTAssert(!response.author.isEmpty)
        XCTAssert(!response.en.isEmpty)
    }
}
