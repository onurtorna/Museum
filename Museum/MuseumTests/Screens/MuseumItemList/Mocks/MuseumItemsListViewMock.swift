//
//  MuseumItemsListViewMock.swift
//  MuseumTests
//
//  Created by Onur Torna on 12.08.2023.
//

@testable import Museum

final class MuseumItemsListViewMock: MuseumItemsListViewable {
    private(set) var applySnapshotParameters: [ArtObject]?
    func applySnapshot(items: [ArtObject]) {
        applySnapshotParameters = items
    }

    private(set) var isShowRefreshButtonCalled = false
    func showRefreshButton() {
        isShowRefreshButtonCalled = true
    }

    private(set) var isHideRefreshButtonCalled = false
    func hideRefreshButton() {
        isHideRefreshButtonCalled = true
    }
}
