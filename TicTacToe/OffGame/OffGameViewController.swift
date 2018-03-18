//
//  OffGameViewController.swift
//  TicTacToe
//
//  Created by Xianning Liu  on 10/03/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol OffGamePresentableListener: class {
  // TODO: Declare properties and methods that the view controller can invoke to perform
  // business logic, such as signIn(). This protocol is implemented by the corresponding
  // interactor class.
}

final class OffGameViewController: UIViewController, OffGamePresentable, OffGameViewControllable {
  
  weak var listener: OffGamePresentableListener?
  private let player1Name: String
  private let player2Name: String
 
  required init?(coder aDecoder: NSCoder) {
    fatalError("Method is not supported")
  }
  
  init(player1Name: String, player2Name: String) {
    self.player1Name = player1Name
    self.player2Name = player2Name
    super.init(nibName: nil, bundle: nil)
  }
}

