//
//  MockURLSessionTask.swift
//  MyFlickrTests
//
//  Created by Nirmal Choudhari on 23/06/21.
//

import Foundation

typealias TaskCompletion = () -> Void

class MockURLSessionTask: URLSessionDataTask {
    private let completion: TaskCompletion

    init(closure: @escaping TaskCompletion) {
        self.completion = closure
    }

    override func resume() {
        completion()
    }
}
