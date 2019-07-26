//
//  CV_AppTests.swift
//  CV AppTests
//
//  Created by Satish Birajdar on 2019-07-18.
//  Copyright © 2019 SBSoftwares. All rights reserved.
//

import XCTest
@testable import CV_App

class WebServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    // make sure the host URL is correct
    func testGetBiodataWithExpectedHostAndURLString() {
        let webService = WebService()
        let mockURLSession  = MockURLSession(data: nil, urlResponse: nil, error: nil)
        webService.session = mockURLSession
        webService.getBiodata { biodatas, error in }
        XCTAssertEqual(webService.chachedURL?.host, "www.mocky.io")
        XCTAssertEqual(webService.chachedURL?.absoluteString, "https://www.mocky.io/v2/5d38e8e39f0000344e9b414b")
    }
    
    // make sure getBiodata request sucess give [biodata] type
    func testGetBiodataSucessReturnsCandidateDetails(){
        let jsonData = "[{\"name\": \"Satish Birajdar\",\"profilePicture\": \"https://rickandmortyapi.com/api/character/avatar/1.jpeg\", \"professionalSummary\": \"Satish has been successfully iOS developer.\",\"skills\": \"Swift 3x\",\"experience\": \"Experience Value\",\"contactDetails\":\"satishbirajdar1@gmail.com\"}]".data(using: .utf8)
        
        let webService = WebService()
        let mockURLSession  = MockURLSession(data: jsonData, urlResponse: nil, error: nil)
        webService.session = mockURLSession
        let biodataExpectation = expectation(description: "biodata")
        var biodatasResponse: [Biodata]?
        
        webService.getBiodata { biodatas, error in
            biodatasResponse = biodatas
            biodataExpectation.fulfill()
        }
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(biodatasResponse)
        }
    }
    
    // test when json response is an error
    func testGetBiodatasWhenResponseErrorReturnsError() {
        let webService = WebService()
        let error = NSError(domain: "error", code: 1234, userInfo: nil)
        let mockURLSession  = MockURLSession(data: nil, urlResponse: nil, error: error)
        webService.session = mockURLSession
        let errorExpectation = expectation(description: "error")
        var errorResponse: Error?
        webService.getBiodata { biodatas, error in
            errorResponse = error
            errorExpectation.fulfill()
        }
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNil(errorResponse)
        }
    }
}
