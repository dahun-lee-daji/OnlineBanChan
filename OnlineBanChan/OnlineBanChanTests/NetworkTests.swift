//
//  NetworkTests.swift
//  OnlineBanChanTests
//
//  Created by 이다훈 on 2022/05/21.
//

import XCTest
@testable import OnlineBanChan
import RxSwift

class NetworkTests: XCTestCase {
    var sut : NetworkService!
    var dataCreater: MockDataCreater!
    var disposeBag = DisposeBag()
    
    override func setUpWithError() throws {
        dataCreater = MockDataCreater.init()
    }
    
    func testCreateURL() {
        
        let testEndpoint = APIEndPoint.getSectionsEndPoint()
        let answer = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/best"
        
        do {
            let testResult = try testEndpoint.asURL().absoluteString
            XCTAssertEqual(testResult, answer)
        } catch {
            XCTFail()
        }
        
    }
    
    func testDecodeWholeResponse() {
        
        let testRequester = MockNetworkRequester
            .init(response: nil,
                  data: dataCreater.makeWholeResponseData(),
                  error: nil)
        
        sut = DefaultNetworkService.init(requester: testRequester)
        
        let whatIWant = dataCreater.testWholeResponse
        let expect = expectation(description: "testDecodeWholeResponse waiting 3sec")
        
        
        let data: Observable<WholeResponse> = sut.request(with: APIEndPoint.getSectionsEndPoint())
        
        data.subscribe({ response in
                
                switch response {
                case .next(let decoded) :
                    XCTAssertEqual(whatIWant, decoded)
                    expect.fulfill()
                case .error :
                    XCTFail()
                case .completed:
                    sleep(1)
                }
        })
        .disposed(by: disposeBag)
        
        wait(for: [expect], timeout: 3)
        
    }
    
    func testRealConnectWithWholeResponse() {
        let expect = expectation(description: "testDecodeWholeResponse waiting 3sec")
        
        sut = DefaultNetworkService.init()
        let data: Observable<WholeResponse> = sut.request(with: APIEndPoint.getSectionsEndPoint())
        
        data.subscribe({ response in
            switch response {
            case .next(let wholeResponse) :
                XCTAssertEqual(wholeResponse.statusCode, 200)
                expect.fulfill()
            case .error(_):
                XCTFail()
            case .completed:
                sleep(1)
            }
        })
        .disposed(by: disposeBag)
        
        wait(for: [expect], timeout: 3)
    }

}
