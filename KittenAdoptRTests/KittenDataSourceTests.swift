//
//  KittenDataSourceTests.swift
//  KittenAdoptR
//
//  Created by Joe Susnick on 6/17/17.
//  Copyright © 2017 Joe Susnick. All rights reserved.
//

import XCTest
@testable import KittenAdoptR

class KittenDataSourceTests: XCTestCase {
    var dataSource: KittenDataSource!
    let tableView = UITableView()

    override func setUp() {
        super.setUp()

        dataSource = KittenDataSource()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.estimatedRowHeight = 44

        for number in 0..<20 {
            let kitten = Kitten(name: "Kitten: \(number)")
            dataSource.kittens.append(kitten)
        }
    }

    func testDataSourceHasKittens() {
        XCTAssertEqual(dataSource.kittens.count, 20,
                       "DataSource should have correct number of kittens")
    }

    func testHasZeroSectionsWhenZeroKittens() {
        dataSource.kittens = []

        XCTAssertEqual(dataSource.numberOfSections(in: tableView), 0,
                       "TableView should have zero sections when no kittens are present")
    }

    func testHasOneSectionWhenKittensArePresent() {
        XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1,
                       "TableView should have one section when kittens are present")
    }

    func testNumberOfRows() {
        let numberOfRows = dataSource.tableView(tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, 20,
                       "Number of rows in table should match number of kittens")
    }

    func testCellForRow() {
        let cell = dataSource.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell.textLabel?.text, "Kitten: 0",
                       "The first cell should display name of first kitten")
    }
}

