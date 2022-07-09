//
//  DefaultFoodImagesRepository.swift
//  OnlineBanChan
//
//  Created by 이다훈 on 2022/05/26.
//

import Foundation
import RxSwift

class DefaultFoodImagesRepository: FoodImagesRepository {
    
    let networkService: NetworkService
    let imageCacher: ImageCacher
    
    init(networkService: NetworkService, imageCacher: ImageCacher) {
        self.networkService = networkService
        self.imageCacher = imageCacher
    }
    
    func fetchFoodImage(with url: String) -> Observable<Data> {
        
        if let cached = getCache(id: url) {
            return Observable.just(cached)
        }
        
        return networkService.request(with: url)
            .compactMap({ $0 })
            .do(onNext: { [unowned self] data in
                setCache(data: data, id: url)
            })
    }
    
    private func setCache(data: Data, id: String) {
        imageCacher.setCache(with: NSData(data: data), id: id)
    }
    
    private func getCache(id: String) -> Data? {
        let cachedData = imageCacher.getCache(id: id)
        guard let cachedData = cachedData else {
            return nil
        }
        
        return Data(cachedData)
    }
    
    
}
