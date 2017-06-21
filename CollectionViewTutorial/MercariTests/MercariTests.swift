//
//  MercariTests.swift
//  MercariTests
//

import XCTest
@testable import Mercari

class MercariTests: XCTestCase {
    
    private var sessionUnderTest: URLSession!
    private let urlString = "https://www.google.com/" // URL that stored the json files. We will use google.com as an example here.
        
    override func setUp() {
        super.setUp()
        sessionUnderTest = URLSession(configuration: .default)
    }
    
    override func tearDown() {
        sessionUnderTest = nil
        super.tearDown()
    }
    
    func testCallToWebGetsHttpStatusCode200() {
        let url = URL(string: urlString)
        let expect = expectation(description: "Completion handler invokved")
        var statusCode: Int?
        var responseError: Error?
        
        let dataTask = sessionUnderTest.dataTask(with: url!) { (data, response, error) in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            expect.fulfill()
        }
        dataTask.resume()
        waitForExpectations(timeout: 5, handler: nil) // Setting for 5 s to fetch the url, if not failed here.
        
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    func testParseJsonInBundle() {
        let path = Bundle.main.path(forResource: "all", ofType: "json")
        let dataToParse = try? Data(contentsOf: URL(fileURLWithPath: path!))
        let parsedData = ParseJsonManager.parseJSONData(data: dataToParse)
        let data = parsedData?["data"]
        let count = data != nil ? 1 : 0
        XCTAssertEqual(count, 1, "Parsed data failed. Data does not exist in json")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
