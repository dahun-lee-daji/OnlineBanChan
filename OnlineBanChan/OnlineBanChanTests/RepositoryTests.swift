//
//  RepositoryTests.swift
//  OnlineBanChanTests
//
//  Created by 이다훈 on 2022/05/26.
//

import XCTest
@testable import OnlineBanChan
import RxSwift

class RepositoryTests: XCTestCase {
    var sut : BanChanRepository!
    var dataCreater: MockDataCreater!
    var disposeBag = DisposeBag()
    
    override func setUpWithError() throws {
        dataCreater = MockDataCreater.init()
        let testRequester = MockNetworkRequester
            .init(response: nil,
                  data: dataCreater.makeWholeResponseData(),
                  error: nil)
        
        let testNetworkService = DefaultNetworkService.init(requester: testRequester)
        
        sut = DefaultBanChanRepository.init(networkService: testNetworkService)
        dataCreater = MockDataCreater.init()
    }
    
    func testfetchDishList() {
        let whatIWant = dataCreater.testMainSection
        let expect = expectation(description: "testDecodeWholeResponse waiting 3sec")
        
        sut.fetchDishList()
            .subscribe({ response in
                
                switch response {
                case.next(let data) :
                    XCTAssertEqual(data.first!, whatIWant)
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

