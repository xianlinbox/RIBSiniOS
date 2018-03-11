//
//  OffGameRouter.swift
//  TicTacToe
//
//  Created by Xianning Liu  on 10/03/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

import RIBs

protocol OffGameInteractable: Interactable {
    weak var router: OffGameRouting? { get set }
    weak var listener: OffGameListener? { get set }
}

protocol OffGameViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class OffGameRouter: ViewableRouter<OffGameInteractable, OffGameViewControllable>, OffGameRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: OffGameInteractable, viewController: OffGameViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
