//
//  MuseumItemsListRouting.swift
//  Museum
//
//  Created by Onur Torna on 11.08.2023.
//

import Foundation

protocol MuseumItemsListRouting: AnyObject, Router, ErrorShowing, LoadingViewShowing {
    func navigateToItemDetail(objectNumber: String)
}
