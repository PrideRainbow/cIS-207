//
//  StockSimulatorUITestsLaunchTests.swift
//  StockSimulatorUITests
//
//  Created by Christopher Walter on 1/29/22.
//

import XCTest

class StockSimulatorUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
