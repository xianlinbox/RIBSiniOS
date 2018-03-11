//
//  LoggedInRouter.swift
//  TicTacToe
//
//  Created by Xianning Liu  on 06/03/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

import RIBs

protocol LoggedInInteractable: Interactable {
  weak var router: LoggedInRouting? { get set }
  weak var listener: LoggedInListener? { get set }
}

protocol LoggedInViewControllable: RootViewControllable {
  // TODO: Declare methods the router invokes to manipulate the view hierarchy. Since
  // this RIB does not own its own view, this protocol is conformed to by one of this
  // RIB's ancestor RIBs' view.
}

final class LoggedInRouter: Router<LoggedInInteractable>, LoggedInRouting {
  
  // TODO: Constructor inject child builder protocols to allow building children.
  init(interactor: LoggedInInteractable, viewController: LoggedInViewControllable, offGameBuildable:OffGameBuildable) {
    self.viewController = viewController
    self.offGameBuildable = offGameBuildable
    super.init(interactor: interactor)
    interactor.router = self
  }
  
  func cleanupViews() {
    // TODO: Since this router does not own its view, it needs to cleanup the views
    // it may have added to the view hierarchy, when its interactor is deactivated.
  }
  
  // MARK: - Private
  private let viewController: LoggedInViewControllable
  private let offGameBuildable: OffGameBuildable
}

