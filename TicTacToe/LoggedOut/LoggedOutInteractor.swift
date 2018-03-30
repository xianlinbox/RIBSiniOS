//
//  LoggedOutInteractor.swift
//  TicTacToe
//
//  Created by Xianning Liu  on 06/03/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

import RIBs
import RxSwift

protocol LoggedOutRouting: ViewableRouting {
}

protocol LoggedOutPresentable: Presentable {
  var listener: LoggedOutPresentableListener? { get set }
}

protocol LoggedOutListener: class {
  func didLogin(withPlayer1Name player1:String, player2:String)
}

final class LoggedOutInteractor: PresentableInteractor<LoggedOutPresentable>, LoggedOutInteractable, LoggedOutPresentableListener {
  
  weak var router: LoggedOutRouting?
  weak var listener: LoggedOutListener?
  
  override init(presenter: LoggedOutPresentable) {
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
  
  func login(withPlayer1Name player1Name: String, withPlayer2Name player2Name: String) {
    listener?.didLogin(withPlayer1Name: player1Name, player2: player2Name)
  }
}

