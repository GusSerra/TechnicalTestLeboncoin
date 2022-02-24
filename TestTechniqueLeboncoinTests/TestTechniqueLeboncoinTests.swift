//
//  TestTechniqueLeboncoinTests.swift
//  TestTechniqueLeboncoinTests
//
//  Created by Gustavo Serra on 24/02/2022.
//

import XCTest
@testable import TestTechniqueLeboncoin

class TestTechniqueLeboncoinTests: XCTestCase {
    
    private let announceListVM = AnnounceListViewModel(networkService: MockNetworkService())

    func testUrgentAnnounces_whenAnnouncesAreLoaded_returnsAllUrgentAnnouncesAtTheTop() {

        announceListVM.fetchAnnounces()
        
        XCTAssertEqual(announceListVM.announcesConfiguration[0].urgency, .urgent)
        XCTAssertEqual(announceListVM.announcesConfiguration[1].urgency, .urgent)
        XCTAssertEqual(announceListVM.announcesConfiguration[2].urgency, .noturgent)
        XCTAssertEqual(announceListVM.announcesConfiguration[3].urgency, .noturgent)
        XCTAssertEqual(announceListVM.announcesConfiguration[4].urgency, .noturgent)
    }

    func testDateUrgentAnnounces_whenAnnouncesAreLoaded_returnsAnnouncesDescendingOrder() {
        
        announceListVM.fetchAnnounces()
        
        XCTAssertGreaterThan(announceListVM.announcesConfiguration[0].creationDate!, announceListVM.announcesConfiguration[1].creationDate!)
    }
    
    func testDateNotUrgentAnnounces_whenAnnouncesAreLoaded_returnsAnnouncesDescendingOrder() {

        announceListVM.fetchAnnounces()
        
        XCTAssertGreaterThan(announceListVM.announcesConfiguration[2].creationDate!, announceListVM.announcesConfiguration[3].creationDate!)
        XCTAssertGreaterThan(announceListVM.announcesConfiguration[3].creationDate!, announceListVM.announcesConfiguration[4].creationDate!)
    }
    
    func testAnnouncesCategory_whenAnnouncesAreLoaded_returnsOnlyAnnouncesFromFilteredCategory() {

        announceListVM.filteredCategory = AnnounceCategory(id: 2, name: "Category2")
        announceListVM.fetchAnnounces()
        
        XCTAssertEqual(announceListVM.announcesConfiguration.count, 3)
    }
}
