//
//  Pagination.swift
//  Museum
//
//  Created by Onur Torna on 12.08.2023.
//

import Foundation

/// Encapsulates pagination related variables
struct Pagination {

    // MARK: - Internal variables

    private(set) var currentPage = 1

    // Prevents pagination to fetch again while actively fetching items
    var isActivelyFetchingItems = false

    /// Shows if pagination is ever used in the lifecycle
    var isPaginationActive = false

    var canLoadMore: Bool {
        shownItems < totalItems
    }

    // MARK: - Private variables
    
    private var shownItems = 0
    private var totalItems = 0

    // MARK: - Mutating functions

    mutating func setTotalItemsCount(_ count: Int) {
        totalItems = count
    }

    mutating func addShownItems(count: Int) {
        shownItems += count
    }

    mutating func incrementPageNumber() {
        currentPage += 1
    }
}
