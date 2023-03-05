//
//  ImagesListConfiguarator.swift
//  StoreLabTask
//
//  Created by Mallikarjuna on 05/03/2023.
//

import Foundation

/// This is Used for Configuaring the ImagesListViewController
class ImagesListConfiguarator {

    // MARK: Configuration
    func configure(viewController: ImagesListViewController) {
        let router = ImagesListRouter()
        router.viewController = viewController
        
        let presenter = ImagesListPresenter()
        presenter.output = viewController
        
        let interactor = ImagesListInteractor()
        interactor.output = presenter
        
        viewController.output = interactor
        viewController.router = router
    }
}
