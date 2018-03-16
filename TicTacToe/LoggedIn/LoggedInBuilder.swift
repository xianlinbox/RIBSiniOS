//
//  LoggedInBuilder.swift
//  TicTacToe
//
//  Created by Xianning Liu  on 06/03/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

import RIBs

protocol LoggedInDependency: Dependency {
  // TODO: Make sure to convert the variable into lower-camelcase.
  var LoggedInViewController: LoggedInViewControllable { get }
  // TODO: Declare the set of dependencies required by this RIB, but won't be
  // created by this RIB.
}

final class LoggedInComponent: Component<LoggedInDependency>, OffGameDependency, InGameDependency {
  let player1Name:String
  let player2Name:String
  
  init(dependency: LoggedInDependency, player1: String, player2: String) {
    self.player1Name = player1
    self.player2Name = player2
    super.init(dependency: dependency)
  }

  fileprivate var LoggedInViewController: LoggedInViewControllable {
    return dependency.LoggedInViewController
  }
  
  // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol LoggedInBuildable: Buildable {
  func build(withListener listener: LoggedInListener, player1: String, player2: String) -> LoggedInRouting
}

final class LoggedInBuilder: Builder<LoggedInDependency>, LoggedInBuildable {
  
  override init(dependency: LoggedInDependency) {
    super.init(dependency: dependency)
  }
  
  func build(withListener listener: LoggedInListener, player1: String, player2: String) -> LoggedInRouting {
    let component = LoggedInComponent(dependency: dependency, player1: player1, player2: player2)
    let interactor = LoggedInInteractor()
    interactor.listener = listener
    
    let offGameBuilder = OffGameBuilder(dependency: component)
    let inGameBuilder = InGameBuilder(dependency: component)
    return LoggedInRouter(interactor: interactor, viewController: component.LoggedInViewController, offGameBuildable: offGameBuilder, inGameBuilder: inGameBuilder)
  }
}

