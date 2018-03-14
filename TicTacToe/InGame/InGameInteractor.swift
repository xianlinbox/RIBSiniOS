//
//  InGameInteractor.swift
//  TicTacToe
//
//  Created by Xianning Liu  on 13/03/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

import RIBs
import RxSwift

protocol InGameRouting: ViewableRouting {
  // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol InGamePresentable: Presentable {
  weak var listener: InGamePresentableListener? { get set }
  // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol InGameListener: class {
  // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class InGameInteractor: PresentableInteractor<InGamePresentable>, InGameInteractable, InGamePresentableListener {
  
  weak var router: InGameRouting?
  weak var listener: InGameListener?
  
  // TODO: Add additional dependencies to constructor. Do not perform any logic
  // in constructor.
  override init(presenter: InGamePresentable) {
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
  func placeCurrentPlayerMark(atRow row: Int, col: Int){
    
  }
  
  func closeGame() {
    
  }
  
}

enum PlayerType: Int {
  case red = 1
  case blue
}

struct GameConstants {
  static let rowCount = 3
  static let colCount = 3
}

