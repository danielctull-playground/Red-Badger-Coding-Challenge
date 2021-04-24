
import Advent
import CodingChallenge
import XCTest

final class CodingChallengeTests: XCTestCase {

    func testPart1Example1() throws {
        let input = try Bundle.module.input(named: "Instructions")
        let result = calculatePositions(input: input)
        XCTAssertEqual(result, """
            1 1 E
            3 3 N LOST
            2 3 S
            """)
    }
}
