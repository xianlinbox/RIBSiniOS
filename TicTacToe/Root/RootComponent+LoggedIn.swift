//
//  RootComponent+LoggedIn.swift
//  TicTacToe
//
//  Created by Xianning Liu  on 06/03/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

import RIBs

/// The dependencies needed from the parent scope of Root to provide for the LoggedOut scope.
// TODO: Update RootDependency protocol to inherit this protocol.
protocol RootDependencyLoggedIn: Dependency {
  
  // TODO: Declare dependencies needed from the parent scope of Root to provide dependencies
  // for the LoggedOut scope.
}

extension RootComponent: LoggedInDependency {
  var LoggedInViewController: LoggedInViewControllable {
    return rootViewController
  }
}
