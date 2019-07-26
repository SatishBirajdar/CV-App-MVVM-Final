//
//  MockURLSession.swift
//  CV App
//
//  Created by Satish Birajdar on 2019-07-26.
//  Copyright © 2019 SBSoftwares. All rights reserved.
//

import Foundation

class MockURLSession: URLSession {
    var cachedUrl: URL?
    
    private let mockTask: MockTask
    init(data: Data?, urlResponse: URLResponse?, error: Error?) {
        mockTask = MockTask(data: data, urlResponse: urlResponse, error:
            error)
    }
        
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.cachedUrl = url
        mockTask.completionHandler = completionHandler
        return mockTask
    }
}
