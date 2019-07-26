//
//  MockTask.swift
//  CV AppTests
//
//  Created by Satish Birajdar on 2019-07-26.
//  Copyright © 2019 SBSoftwares. All rights reserved.
//

import Foundation

class MockTask: URLSessionDataTask {
    private let data: Data?
    private let urlResponse: URLResponse?
    private let error1: Error?
    
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    init(data: Data?, urlResponse: URLResponse?, error: Error?) {
        self.data = data
        self.urlResponse = urlResponse
        self.error1 = error
    }
    override func resume() {
        DispatchQueue.main.async {
            self.completionHandler?(self.data, self.urlResponse, self.error1)
        }
    }
}
