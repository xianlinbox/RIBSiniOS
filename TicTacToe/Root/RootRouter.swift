//
//  Copyright (c) 2017. Uber Technologies
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import RIBs

protocol RootInteractable: Interactable, LoggedOutListener, LoggedInListener {
  var router: RootRouting? { get set }
  var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
  func present(viewController: ViewControllable)
  func dismiss(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
  init(interactor: RootInteractable,
       viewController: RootViewControllable,
       loggedOutBuilder: LoggedOutBuildable,
       loggedInBuilder: LoggedInBuildable) {
    
    self.loggedOutBuilder = loggedOutBuilder
    self.loggedInBuilder = loggedInBuilder
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  override func didLoad() {
    super.didLoad()

    let loggedOut = loggedOutBuilder.build(withListener: interactor)
    self.loggedOut = loggedOut
    attachChild(loggedOut)
    viewController.present(viewController: loggedOut.viewControllable)
  }
  
  //MARK: - Root Routing
  func routeToLoggedIn(withPlayer1 player1: String, player2: String) {
    if let loggedOut = self.loggedOut {
      detachChild(loggedOut)
      viewController.dismiss(viewController: loggedOut.viewControllable)
      self.loggedOut = loggedOut
    }
    
    let loggedIn = loggedInBuilder.build(withListener: interactor, player1: player1, player2: player2)
    attachChild(loggedIn.router)
  }
  
  // MARK: - Private
  private let loggedOutBuilder: LoggedOutBuildable
  private let loggedInBuilder: LoggedInBuildable
  private var loggedOut: ViewableRouting?
}

