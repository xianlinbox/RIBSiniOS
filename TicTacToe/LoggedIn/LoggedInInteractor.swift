//
//  LoggedInInteractor.swift
//  TicTacToe
//
//  Created by Xianning Liu  on 06/03/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

import RIBs
import RxSwift

protocol LoggedInRouting: Routing {
  func routeToOffGame()
  func routeToInGame()
  func cleanupViews()
}

protocol LoggedInListener: class {
  // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class LoggedInInteractor: Interactor, LoggedInInteractable {
  weak var router: LoggedInRouting?
  weak var listener: LoggedInListener?
  
  // TODO: Add additional dependencies to constructor. Do not perform any logic
  // in constructor.
  override init() {}
  
  override func didBecomeActive() {
    super.didBecomeActive()
  }
  
  override func willResignActive() {
    super.willResignActive()
    router?.cleanupViews()
  }
  
  func gameDidEnd() {
    router?.routeToOffGame()
  }
}

