//
//  InGameRouter.swift
//  TicTacToe
//
//  Created by Xianning Liu  on 13/03/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

import RIBs

protocol InGameInteractable: Interactable {
  var router: InGameRouting? { get set }
  var listener: InGameListener? { get set }
}

protocol InGameViewControllable: ViewControllable {
  // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class InGameRouter: ViewableRouter<InGameInteractable, InGameViewControllable>, InGameRouting {
  
  // TODO: Constructor inject child builder protocols to allow building children.
  override init(interactor: InGameInteractable, viewController: InGameViewControllable) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
}
