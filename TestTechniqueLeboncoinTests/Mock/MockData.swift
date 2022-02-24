//
//  MockData.swift
//  TestTechniqueLeboncoinTests
//
//  Created by Gustavo Serra on 24/02/2022.
//

import Foundation
@testable import TestTechniqueLeboncoin

class MockData {
    
    static func loadMockAnnounces() -> [Announce] {
        
        guard let path = Bundle.main.path(forResource: "announces", ofType: "json") else {
            fatalError("Path for announces.json was not found")
        }
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            fatalError("Unable to load data!")
        }
        
        guard let mockedAnnounces = try? JSONDecoder().decode([Announce].self, from: data) else {
            fatalError("Unable to decode data!")
        }
        
        return mockedAnnounces
    }
    
    static func loadMockCategories() -> [AnnounceCategory] {
        
        guard let path = Bundle.main.path(forResource: "categories", ofType: "json") else {
            fatalError("Path for categories.json was not found")
        }
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            fatalError("Unable to load data!")
        }
        
        guard let mockedCategories = try? JSONDecoder().decode([AnnounceCategory].self, from: data) else {
            fatalError("Unable to decode data!")
        }
        
        return mockedCategories
    }
}
