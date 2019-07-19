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
    func testGetBiodataWithExpectedHostAndURLString(){
        let webService = WebService()
        webService.getBiodata { biodatas, error in
            XCTAssertEqual(webService.chachedURL?.host, "www.mocky.io")
            XCTAssertEqual(webService.chachedURL?.absoluteString, "https://www.mocky.io/v2/5d27aa2e320000570071bc42")
        }
    }
    
    // make sure getBiodata request sucess give [biodata] type
    func testGetBiodataSucessReturnsCandidateDetails(){
        let webService = WebService()
        var biodatasResponse: [Biodata]?
        let biodataExpectation = expectation(description: "biodata")
        webService.getBiodata { biodatas, error in
            biodatasResponse = biodatas
            biodataExpectation.fulfill()
        }
        waitForExpectations(timeout: 2) { (error) in
            XCTAssertNotNil(biodatasResponse)
        }
    }
}

