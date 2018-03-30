//
//  LoggedInRouter.swift
//  TicTacToe
//
//  Created by Xianning Liu  on 06/03/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

import RIBs

protocol LoggedInInteractable: Interactable, OffGameListener, InGameListener {
  var router: LoggedInRouting? { get set }
  var listener: LoggedInListener? { get set }
}

protocol LoggedInViewControllable: RootViewControllable {
  // TODO: Declare methods the router invokes to manipulate the view hierarchy. Since
  // this RIB does not own its own view, this protocol is conformed to by one of this
  // RIB's ancestor RIBs' view.
  func present(viewController: ViewControllable)
  func dismiss(viewController: ViewControllable)
}

final class LoggedInRouter: Router<LoggedInInteractable>, LoggedInRouting {
  
  // TODO: Constructor inject child builder protocols to allow building children.
  init(interactor: LoggedInInteractable, viewController: LoggedInViewControllable, offGameBuildable: OffGameBuildable, inGameBuilder: InGameBuildable) {
    self.viewController = viewController
    self.offGameBuildable = offGameBuildable
    self.inGameBuilder = inGameBuilder
    super.init(interactor: interactor)
    interactor.router = self
  }
  
  override func didLoad() {
    super.didLoad()
    attachOffGame()
  }
  
  func routeToInGame() {
    detachCurrentChild()
    attachInGame()
  }
  
  func routeToOffGame() {
    detachCurrentChild()
    attachOffGame()
  }
  
  func cleanupViews() {
    if let currentChild = currentChild {
      viewController.dismiss(viewController: currentChild.viewControllable)
    }
  }
  
  // MARK: - Private
  private let viewController: LoggedInViewControllable
  private let offGameBuildable: OffGameBuildable
  private let inGameBuilder: InGameBuildable
  private var currentChild: ViewableRouting?
  
  private func attachOffGame() {
    let offGame = offGameBuildable.build(withListener: interactor)
    self.currentChild = offGame
    attachChild(offGame)
    viewController.present(viewController: offGame.viewControllable)
  }
  
  private func detachCurrentChild() {
    if let currentChild = currentChild {
      detachChild(currentChild)
      viewController.dismiss(viewController: currentChild.viewControllable)
    }
  }
  
  private func attachInGame() {
    let inGame = inGameBuilder.build(withListener: interactor)
    self.currentChild = inGame
    attachChild(inGame)
    viewController.present(viewController: inGame.viewControllable)
  }
}

