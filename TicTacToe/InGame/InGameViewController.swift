//
//  InGameViewController.swift
//  TicTacToe
//
//  Created by Xianning Liu  on 13/03/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol InGamePresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class InGameViewController: UIViewController, InGamePresentable, InGameViewControllable {

    weak var listener: InGamePresentableListener?
}
