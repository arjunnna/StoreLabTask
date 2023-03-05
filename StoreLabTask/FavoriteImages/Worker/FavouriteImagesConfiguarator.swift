//
//  FavouriteImagesConfiguarator.swift
//  StoreLabTask
//
//  Created by Mallikarjuna on 05/03/2023.
//

import Foundation

/// This is Used for Configuaring the FavouriteImagesViewController
class FavouriteImagesConfiguarator {

    // MARK: Configuration
    func configure(viewController: FavouriteImagesViewController) {
        let router = FavouriteImagesRouter()
        router.viewController = viewController
        
        let presenter = FavouritesImagesListPresenter()
        presenter.output = viewController
        
        let interactor = FavouriteImagesInteractor()
        interactor.output = presenter
        
        viewController.output = interactor
        viewController.router = router
    }
}
