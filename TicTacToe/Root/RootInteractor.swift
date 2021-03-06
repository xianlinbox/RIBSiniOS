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
import RxSwift

protocol RootRouting: ViewableRouting {
  func routeToLoggedIn(withPlayer1 payer1:String, player2:String)
}

protocol RootPresentable: Presentable {
  var listener: RootPresentableListener? { get set }
}

protocol RootListener: class {
}

public protocol RootActionableItem: class {
  func waitForLogin() -> Observable<(LoggedInActionableItem, ())>
}


final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener, RootActionableItem,
UrlHandler {
  weak var router: RootRouting?
  weak var listener: RootListener?
  
  // TODO: Add additional dependencies to constructor. Do not perform any logic
  // in constructor.
  override init(presenter: RootPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  override func didBecomeActive() {
    super.didBecomeActive()
    // TODO: Implement business logic here.
  }
  
  override func willResignActive() {
    super.willResignActive()
    // TODO: Pause any business logic.
  }
  
  func didLogin(withPlayer1Name player1: String, player2: String) {
    router?.routeToLoggedIn(withPlayer1: player1, player2: player2)
  }
  
  func waitForLogin() -> Observable<(LoggedInActionableItem, ())> {
    return loggedInActionableItemSubject
      .map { (loggedInItem: LoggedInActionableItem) -> (LoggedInActionableItem, ()) in
        (loggedInItem, ())
    }
  }
  //MARK: - UrlHandler
  func handle(_ url: URL) {
    let lauchGameWorkflow = LaunchGameWorkflow(url:url)
    lauchGameWorkflow
      .subscribe(self)
      .disposeOnDeactivate(interactor:self)
    
  }
  
  //MARK: - private
  private let loggedInActionableItemSubject = ReplaySubject<LoggedInActionableItem>.create(bufferSize: 1)
}

