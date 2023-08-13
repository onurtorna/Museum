//
//  MuseumItemDetailInteractorMock.swift
//  MuseumTests
//
//  Created by Onur Torna on 13.08.2023.
//

@testable import Museum

final class MuseumItemDetailInteractorMock: MuseumItemDetailInteractorInputProtocol {
    private(set) var isGetItemDetailCalled = false
    func getItemDetail() {
        isGetItemDetailCalled = true
    }
}
