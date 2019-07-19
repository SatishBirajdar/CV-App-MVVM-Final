//
//  CV_AppUITests.swift
//  CV AppUITests
//
//  Created by Satish Birajdar on 2019-07-18.
//  Copyright © 2019 SBSoftwares. All rights reserved.
//

import XCTest

class CV_AppUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        
        app = XCUIApplication()
        
        // We send a command line argument to our app,
        // to enable it to reset its state
        app.launchArguments.append("--uitesting")
    }
    
    func testShowHomeScreen(){
        app.launch()
        
        // Make sure we're displaying Resume Home screen
        XCTAssertTrue(app.isDisplayingResumeHomeScreen)
    }
    
}

extension XCUIApplication {
    var isDisplayingResumeHomeScreen: Bool {
        return otherElements["ResumeHomeScreen"].exists
    }
}
