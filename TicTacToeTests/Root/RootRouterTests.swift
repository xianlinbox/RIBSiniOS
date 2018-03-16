//
//  RootRouterTests.swift
//  TicTacToeTests
//
//  Created by Xianning Liu  on 15/03/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

@testable import TicTacToe
import XCTest
import Quick
import Nimble

final class RootRouterTests: XCTestCase {
  private var router: RootRouter!
  private var loggedInBuilder: LoggedInBuildableMock!
  private var rootInteractor: RootInteractableMock!
  
  override func setUp() {
    super.setUp()
    rootInteractor = RootInteractableMock()
    let viewController = RootViewControllableMock()
    loggedInBuilder = LoggedInBuildableMock()
    let loggedOutBuilder = LoggedOutBuildableMock()
    router = RootRouter(interactor: rootInteractor, viewController: viewController, loggedOutBuilder: loggedOutBuilder, loggedInBuilder: loggedInBuilder)
  }
  
  func test_routeToLoggedIn_invokesToExampleResult() {
    let loggedInRouter = LoggedInRoutingMock(interactable: LoggedInInteractableMock())
    var assignedListener: LoggedInListener? = nil
    loggedInBuilder.buildHandler = { (_ listener: LoggedInListener) -> (LoggedInRouting) in
      assignedListener = listener
      return loggedInRouter
    }
    
    XCTAssertNil(assignedListener)
    XCTAssertEqual(loggedInBuilder.buildCallCount, 0)
    XCTAssertEqual(loggedInRouter.loadCallCount, 0)
    
    router.routeToLoggedIn(withPlayer1: "1", player2: "2")
    
    XCTAssertTrue(assignedListener === rootInteractor)
    XCTAssertEqual(loggedInBuilder.buildCallCount, 1)
    XCTAssertEqual(loggedInRouter.loadCallCount, 1)
  }
}

