//
//  KittenTests.swift
//  KittenAdoptR
//
//  Created by Joe Susnick on 6/17/17.
//  Copyright © 2017 Joe Susnick. All rights reserved.
//

import XCTest
@testable import KittenAdoptR

class KittenTests: XCTestCase {
    
    func testKittenHasAName() {
        let kitten = Kitten(name: "Uncle Fester")
        XCTAssertEqual(kitten.name, "Uncle Fester",
                       "Kitten name should be set in initializer")
    }

    func testKittenIsNotAdoptableByDefault() {
        let kitten = Kitten(name: "Uncle Fester")
        XCTAssertFalse(kitten.isAdoptable,
                       "Kitten should not be adoptable by default")
    }

    func testKittenCanBeSetToAdoptable() {
        let kitten = Kitten(name: "Uncle Fester")
        kitten.isAdoptable = true
        XCTAssertTrue(kitten.isAdoptable,
                      "Kitten may be set to adoptable")
    }
}
