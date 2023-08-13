//
//  Pagination.swift
//  Museum
//
//  Created by Onur Torna on 12.08.2023.
//

import Foundation

/// Encapsulates pagination related variables
final class Pagination {

    // MARK: - Internal variables

    private(set) var currentPage = 1
    // Internal for test purposes
    private(set) var shownItems = 0
    // Internal for test purposes
    private(set) var totalItems = 0

    // Prevents pagination to fetch again while actively fetching items
    var isActivelyFetchingItems = false

    /// Shows if pagination is ever used in the lifecycle
    var isPaginationActive = false

    var canLoadMore: Bool {
        shownItems < totalItems
    }

    // MARK: - Internal functions

    func setTotalItemsCount(_ count: Int) {
        totalItems = count
    }

    func addShownItems(count: Int) {
        shownItems += count
    }

    func incrementPageNumber() {
        currentPage += 1
    }
}
