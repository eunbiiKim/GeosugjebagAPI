import XCTest

@testable import GeosugjebagAPI

public final class GeosugjebagAPITests: XCTestCase {
    public func testList() async throws {
        let (data, response) = try await GeosugjebagAPI.list(offset: 1, limit: 10, query: "거제하늘애").request()
        
        XCTAssertFalse(data.isEmpty)
    }
}
