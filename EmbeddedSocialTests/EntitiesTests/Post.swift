//
//  Post.swift
//  EmbeddedSocialTests
//
//  Created by Igor Popov on 8/3/17.
//  Copyright © 2017 Akvelon. All rights reserved.
//

import XCTest




class Post: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "topicview_source", ofType: "json")!
        let data = NSData(contentsOfFile: path)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
    
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}