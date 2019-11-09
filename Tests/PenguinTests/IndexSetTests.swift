import XCTest
@testable import Penguin

final class IndexSetTests: XCTestCase {

    func testInitializer() {
        let s = PIndexSet(indices: [1, 4, 8], count: 10)
        XCTAssertEqual(s,
                       PIndexSet([false,
                                  true,
                                  false,
                                  false,
                                  true,
                                  false,
                                  false,
                                  false,
                                  true,
                                  false],
                                 setCount: 3))
    }

    func testUnion() {
        let lhs = PIndexSet([true, false, false, true], setCount: 2)
        let rhs = PIndexSet([true, true, false, false], setCount: 2)
        let expected = PIndexSet([true, true, false, true], setCount: 3)
        XCTAssertEqual(try! lhs.unioned(rhs), expected)
    }

    func testUnionExtension() {
        let lhs = PIndexSet([true, false, true, false], setCount: 2)
        let rhs = PIndexSet([true, true], setCount: 2)
        let expected = PIndexSet([true, true, true, false], setCount: 3)
        XCTAssertEqual(try! lhs.unioned(rhs, extending: true), expected)
        XCTAssertEqual(try! rhs.unioned(lhs, extending: true), expected)
    }

    func testIntersect() {
        let lhs = PIndexSet([true, false, false, true], setCount: 2)
        let rhs = PIndexSet([true, true, false, false], setCount: 2)
        let expected = PIndexSet([true, false, false, false], setCount: 1)
        XCTAssertEqual(try! lhs.intersected(rhs), expected)
    }

    func testIntersectExtension() {
        let lhs = PIndexSet([true, false, true, false], setCount: 2)
        let rhs = PIndexSet([true, true], setCount: 2)
        let expected = PIndexSet([true, false, false, false], setCount: 1)
        XCTAssertEqual(try! lhs.intersected(rhs, extending: true), expected)
        XCTAssertEqual(try! rhs.intersected(lhs, extending: true), expected)
    }

    static var allTests = [
        ("testUnion", testUnion),
        ("testUnionExtension", testUnionExtension),
        ("testIntersect", testIntersect),
        ("testIntersectExtension", testIntersectExtension),
    ]
}
