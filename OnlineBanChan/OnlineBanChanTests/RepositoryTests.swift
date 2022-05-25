//
//  RepositoryTests.swift
//  OnlineBanChanTests
//
//  Created by 이다훈 on 2022/05/26.
//

import XCTest
@testable import OnlineBanChan
import RxSwift
import RxBlocking

class RepositoryTests: XCTestCase {
    var sut : Repository!
    var dataCreater: MockDataCreater!
    var testRequester: NetworkRequesting!
    var testNetworkService: NetworkService!
    
    var disposeBag = DisposeBag()
    
    override func setUpWithError() throws {
        dataCreater = MockDataCreater.init()
        testRequester = MockNetworkRequester
            .init(response: nil,
                  data: dataCreater.makeWholeResponseData(),
                  error: nil)
        
        testNetworkService = DefaultNetworkService.init(requester: testRequester)
        dataCreater = MockDataCreater.init()
    }
    
    func testfetchDishListWithMockingNetwork() {
        sut = DefaultBanChanRepository.init(networkService: testNetworkService)
        let whatIWant = dataCreater.testMainSection
        let expect = expectation(description: "testDecodeWholeResponse waiting 3sec")
        
        (sut as! BanChanRepository).fetchDishList()
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
    
    func testfetchImage() {
        testRequester = DefaultNetworkRequester.init()
        testNetworkService = DefaultNetworkService.init(requester: testRequester)
        sut = DefaultFoodImagesRepository.init(networkService: testNetworkService)
        
        let expect = expectation(description: "testfetchImage waiting 3sec")
        
        let result = try? (sut as! FoodImagesRepository).fetchFoodImage(with:  "https://public.codesquad.kr/jk/storeapp/data/main/739_ZIP_P__T.jpg")
            .toBlocking()
            .first()
            
        XCTAssertNotNil(result)
        expect.fulfill()
        
        wait(for: [expect], timeout: 3)
    }
}

