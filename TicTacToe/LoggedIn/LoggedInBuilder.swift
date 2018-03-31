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

final class LoggedInComponent: Component<LoggedInDependency>, InGameDependency {
  let player1Name:String
  let player2Name:String
  var mutableScoreStream: MutableScoreStream {
    return shared { ScoreStreamImpl() }
  }
  
  init(dependency: LoggedInDependency, player1: String, player2: String) {
    self.player1Name = player1
    self.player2Name = player2
    super.init(dependency: dependency)
  }

  fileprivate var LoggedInViewController: LoggedInViewControllable {
    return dependency.LoggedInViewController
  }
}

extension LoggedInComponent: OffGameDependency {
  var scoreStream: ScoreStream {
    return mutableScoreStream
  }
}
// MARK: - Builder

protocol LoggedInBuildable: Buildable {
  func build(withListener listener: LoggedInListener, player1: String, player2: String) -> (router:LoggedInRouter, actionaleItem: LoggedInActionableItem)
}

final class LoggedInBuilder: Builder<LoggedInDependency>, LoggedInBuildable {
  
  override init(dependency: LoggedInDependency) {
    super.init(dependency: dependency)
  }
  
  func build(withListener listener: LoggedInListener, player1: String, player2: String) -> (router:LoggedInRouter, actionaleItem: LoggedInActionableItem) {
    let component = LoggedInComponent(dependency: dependency, player1: player1, player2: player2)
    let interactor = LoggedInInteractor(scoreStream: component.mutableScoreStream)
    interactor.listener = listener
    
    let offGameBuilder = OffGameBuilder(dependency: component)
    let inGameBuilder = InGameBuilder(dependency: component)
    let router = LoggedInRouter(interactor: interactor, viewController: component.LoggedInViewController, offGameBuildable: offGameBuilder, inGameBuilder: inGameBuilder)
    return (router, interactor)
  }
}

