//
//  RootComponent+LoggedIn.swift
//  TicTacToe
//
//  Created by Xianning Liu  on 06/03/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

import RIBs


extension RootComponent: LoggedInDependency {
  var LoggedInViewController: LoggedInViewControllable {
    return rootViewController
  }
}
