//
//  MuseumItemsListPresenterMock.swift
//  MuseumTests
//
//  Created by Onur Torna on 13.08.2023.
//

import XCTest
@testable import Museum

final class MuseumItemsListPresenterMock: MuseumItemsListInteractorOutputProtocol {

    var gotMuseumItemsExpectation: XCTestExpectation?
    func gotMuseumItems(items: [ArtObject], totalItemCount: Int) {
        gotMuseumItemsExpectation?.fulfill()
    }

    var getMuseumItemsFailedExpectation: XCTestExpectation?
    func getMuseumItemsFailed(errorMessage: String) {
        getMuseumItemsFailedExpectation?.fulfill()
    }
}
