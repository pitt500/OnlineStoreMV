//
//  OnlineStoreMV_UITests.swift
//  OnlineStoreMVUITests
//
//  Created by Pedro Rojas on 01/10/24.
//

import XCTest

final class OnlineStoreMV_UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchEnvironment["UI_Testing_Enabled"] = "YES"
        app.launch()
    }
    
    @MainActor
    func testLoadProductsScreenComponents() {
        let navTitle = app.staticTexts["Products"]
        XCTAssertTrue(navTitle.exists, "Products title not found")
        
        let progressView = app.activityIndicators["progressViewProductList"]
        XCTAssertTrue(progressView.waitForExistence(timeout: 5), "The ProgressView should appear while loading.")
        
        let goToCartButton = app.buttons["goToCartButton"]
        XCTAssertTrue(goToCartButton.exists, "The goToCartButton is not visible.")
        
        let productList = app.collectionViews["productList"]
        XCTAssertTrue(productList.waitForExistence(timeout: 3), "The product list should appear after loading finishes.")
    }
    
    @MainActor
    func testSendingTwoProductsToCart() {
        let productList = app.collectionViews["productList"]
        XCTAssertTrue(productList.waitForExistence(timeout: 3), "The product list should appear after loading finishes.")
        
        let cell1 = productList.children(matching: .cell).element(boundBy: 0)
        cell1.buttons["Add to Cart"].tap()
        
        let cell2 = productList.children(matching: .cell).element(boundBy: 1)
        cell2.swipeUp()
        cell2.swipeUp()
        cell2.buttons["Add to Cart"].tap()
        
        
        XCTAssertTrue(cell1.staticTexts["productQuantity"].label == "1", "Product quantity is not 1")
        XCTAssertTrue(cell2.staticTexts["productQuantity"].label == "1", "Product quantity is not 1")
        
        
        let goToCartButton = app.buttons["goToCartButton"]
        goToCartButton.tap()
        
        
        let cartList = app.collectionViews["cartList"]
        XCTAssertTrue(cartList.waitForExistence(timeout: 3), "The cart list is not appearing.")
        XCTAssertTrue(cartList.cells.count == 2, "The cart list should contain two products.")
    }
    
    @MainActor
    func testPayOrder() {
        let productList = app.collectionViews["productList"]
        XCTAssertTrue(productList.waitForExistence(timeout: 3), "The product list should appear after loading finishes.")
        
        //Adding 3 items to the cart (total 3)
        let cell1 = productList.children(matching: .cell).element(boundBy: 0)
        cell1.buttons["Add to Cart"].tap()
        cell1/*@START_MENU_TOKEN@*/.buttons["+"]/*[[".cells.buttons[\"+\"]",".buttons[\"+\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        cell1/*@START_MENU_TOKEN@*/.buttons["+"]/*[[".cells.buttons[\"+\"]",".buttons[\"+\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        //Adding 1 item to the cart (total 4)
        let cell2 = productList.children(matching: .cell).element(boundBy: 1)
        cell2.swipeUp()
        cell2.swipeUp()
        cell2.buttons["Add to Cart"].tap()
        cell2.swipeUp()
        
        //Adding 3 items to the cart (total 7)
        let cell3 = productList.children(matching: .cell).element(boundBy: 0)
        cell3.buttons["Add to Cart"].tap()
        cell3/*@START_MENU_TOKEN@*/.buttons["+"]/*[[".cells.buttons[\"+\"]",".buttons[\"+\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        cell3/*@START_MENU_TOKEN@*/.buttons["+"]/*[[".cells.buttons[\"+\"]",".buttons[\"+\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let goToCartButton = app.buttons["goToCartButton"]
        goToCartButton.tap()
        
        
        let cartList = app.collectionViews["cartList"]
        XCTAssertTrue(cartList.waitForExistence(timeout: 3), "The cart list is not appearing.")
        
        let payButton = app.buttons["payButton"]
        payButton.tap()
        
        let confirmationAlert = app.alerts["Confirm your purchase"]
        XCTAssertTrue(confirmationAlert.waitForExistence(timeout: 3), "The confirmation alert should appear.")
        
        let alertDescription = confirmationAlert.staticTexts.element(boundBy: 1).label
        XCTAssertTrue(alertDescription.contains("$130"), "The total amount should be $130.00.")
        confirmationAlert.buttons["Yes"].tap()
        
        let progressView = app.activityIndicators["progressViewPayment"]
        XCTAssertTrue(progressView.waitForExistence(timeout: 3), "The payment progress indicator should appear.")
        
        app.alerts["Thank you!"]
            .buttons["Done"].tap()
        
        XCTAssertTrue(productList.waitForExistence(timeout: 3), "The product list should appear after paying.")
    }

//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                app.launch()
//            }
//        }
//    }
}
