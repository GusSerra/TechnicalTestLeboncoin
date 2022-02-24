//
//  MockNetworkService.swift
//  TestTechniqueLeboncoinTests
//
//  Created by Gustavo Serra on 24/02/2022.
//

import Foundation
@testable import TestTechniqueLeboncoin

final class MockNetworkService: NetworkServiceProtocol {
    
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T?,NetworkError>) -> ()) {
        
        var data:T?
        if T.self is [Announce].Type {
            data = MockData.loadMockAnnounces() as? T
        } else if T.self is [AnnounceCategory].Type {
            data = MockData.loadMockCategories() as? T
        }
        
        completion(.success(data))
    }
}
