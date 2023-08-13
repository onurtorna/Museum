//
//  MuseumItemDetailPresenterMock.swift
//  MuseumTests
//
//  Created by Onur Torna on 13.08.2023.
//

import XCTest
@testable import Museum

final class MuseumItemDetailPresenterMock: MuseumItemDetailInteractorOutputProtocol {
    var gotMuseumItemDetailExpectation: XCTestExpectation?
    func gotMuseumItemDetail(_ item: ArtObjectDetail) {
        gotMuseumItemDetailExpectation?.fulfill()
    }

    var getMuseumItemDetailFailedExpectation: XCTestExpectation?
    func getMuseumItemDetailFailed(errorMessage: String) {
        getMuseumItemDetailFailedExpectation?.fulfill()
    }
}
