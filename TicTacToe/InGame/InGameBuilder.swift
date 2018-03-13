//
//  InGameBuilder.swift
//  TicTacToe
//
//  Created by Xianning Liu  on 13/03/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

import RIBs

protocol InGameDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class InGameComponent: Component<InGameDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol InGameBuildable: Buildable {
    func build(withListener listener: InGameListener) -> InGameRouting
}

final class InGameBuilder: Builder<InGameDependency>, InGameBuildable {

    override init(dependency: InGameDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: InGameListener) -> InGameRouting {
        let component = InGameComponent(dependency: dependency)
        let viewController = InGameViewController()
        let interactor = InGameInteractor(presenter: viewController)
        interactor.listener = listener
        return InGameRouter(interactor: interactor, viewController: viewController)
    }
}
