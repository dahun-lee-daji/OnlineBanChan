//
//  NetworkTests.swift
//  OnlineBanChanTests
//
//  Created by 이다훈 on 2022/05/21.
//

import XCTest
@testable import OnlineBanChan

class NetworkTests: XCTestCase {
    var sut : NetworkService!
    var dataCreater: MockDataCreater!
    
    override func setUpWithError() throws {
        dataCreater = MockDataCreater.init()
        
        let testRequester = MockNetworkRequester
            .init(response: nil,
                  data: dataCreater.makeWholeResponseData(),
                  error: nil)
        
        sut = .init(requester: testRequester)
    }
    
    func testCreateURL() {
        let testEndpoint = EndPoint.init(apiPath: .sections, httpMethod: .get)
        let answer = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/best"
        
        do {
            let testResult = try testEndpoint.asURL().absoluteString
            XCTAssertEqual(testResult, answer)
        } catch {
            XCTFail()
        }
        
    }
    
    func testDecodeWholeResponse() {
        let whatIWant = dataCreater.testWholeResponse
        let expect = expectation(description: "testDecodeWholeResponse waiting 5sec")
        sut.getSections()
            .single()
            .subscribe({ so in
                
                switch so {
                case .next(let decoded) :
                    XCTAssertEqual(whatIWant, decoded)
                    expect.fulfill()
                case .error :
                    XCTFail()
                case .completed:
                    sleep(1)
                }
                
            })
        
        wait(for: [expect], timeout: 5)
        
    }
    
    func testRealConnectWholeResponse() {
        
    }

}
