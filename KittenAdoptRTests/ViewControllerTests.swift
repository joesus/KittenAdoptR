//
//  ViewControllerTests.swift
//  KittenAdoptR
//
//  Created by Joe Susnick on 6/16/17.
//  Copyright © 2017 Joe Susnick. All rights reserved.
//

import XCTest
@testable import KittenAdoptR

class ViewControllerTests: XCTestCase {

    var controller: ViewController!
    var tableView: UITableView!
    var dataSource: KittenDataSource!
    var delegate: UITableViewDelegate!

    override func setUp() {
        super.setUp()

        guard let vc = UIStoryboard(name: "Main", bundle: Bundle(for: ViewController.self))
            .instantiateInitialViewController() as? ViewController else {
                return XCTFail("Could not instantiate ViewController from main storyboard")
        }

        controller = vc
        controller.loadViewIfNeeded()
        tableView = controller.tableView

        guard let ds = tableView.dataSource as? KittenDataSource else {
            return XCTFail("Controller's table view should have a kitten data source")
        }

        dataSource = ds
        delegate = tableView.delegate
    }

    func testTableViewHasCells() {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")

        XCTAssertNotNil(cell,
                        "TableView should be able to dequeue cell with identifier: 'Cell'")
    }

    func testKittenCellHasDisclosureIndicatorWhenAdoptable() {
        let kitten = Kitten(name: "Adopt Me")
        kitten.isAdoptable = true
        dataSource.kittens.append(kitten)

        let cell = dataSource.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell.accessoryType, .disclosureIndicator,
                       "Cell should have disclosureIndicator for adoptable kitten")
    }

    func testKittenCellDoesNotHaveDisclosureIndicatorWhenNotAdoptable() {
        let kitten = Kitten(name: "Cannot Adopt Me")
        dataSource.kittens.append(kitten)

        let cell = dataSource.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell.accessoryType, .none,
                       "Cell should have no disclosureIndicator for a non-adoptable kitten")

    }

    func testTableViewDelegateIsViewController() {
        XCTAssertTrue(tableView.delegate === controller,
                      "Controller should be delegate for the table view")
    }

    func testCannotSelectCellWhenNotAdoptable() {
        let kitten = Kitten(name: "Cannot Adopt Me")
        dataSource.kittens.append(kitten)

        XCTAssertNil(delegate.tableView?(tableView, willSelectRowAt: IndexPath(row: 0, section: 0)),
                     "Delegate should not allow cell selection for non-adoptable kittens")
    }

    func testCanSelectCellWhenAdoptable() {
        let kitten = Kitten(name: "Adopt Me")
        kitten.isAdoptable = true
        dataSource.kittens.append(kitten)

        XCTAssertEqual(delegate.tableView?(tableView, willSelectRowAt: IndexPath(row: 0, section: 0)), IndexPath(row: 0, section: 0),
                       "Delegate should allow cell selection for adoptable kittens")
    }

    func testURLOpenerProtocol() {
        XCTAssertTrue(UIApplication.shared is URLOpener,
                      "UIApplication.shared should conform to URLOpener")
    }

    func testDefaultOpenerForDelegate() {
        XCTAssertTrue(controller.opener === UIApplication.shared,
                      "Shared application should be default opener for delegate")
    }

    func testSelectingCellOpensURL() {
        let kitten = Kitten(name: "AdoptableKitten")
        kitten.isAdoptable = true
        dataSource.kittens.append(kitten)

        let mockURLOpener = MockURLOpener()
        controller.opener = mockURLOpener

        delegate.tableView?(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))

        guard mockURLOpener.openURLCalled,
            let url = mockURLOpener.openURLURL else {
                return XCTFail("Should have called openURL on url opener")
        }

        XCTAssertEqual(url, URL(string: "https://www.google.com/search?q=AdoptableKitten"),
                       "Should attempt to open correct url")
    }
}

private class MockURLOpener: URLOpener {
    var openURLCalled = false
    var openURLURL: URL?

    func openURL(_ url: URL) -> Bool {
        openURLCalled = true
        openURLURL = url

        return true
    }
}
