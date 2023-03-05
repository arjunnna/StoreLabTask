//
//  ImagesListRouter.swift
//  StoreLabTask
//
//  Created by Mallikarjuna on 05/03/2023.
//

import Foundation
import UIKit
 
protocol ImagesListRouterInput {
    func navigateToImageDetailVc(_ imageModel: ImageModel)
}

/// This is Used for navigate to Image Details ViewController
class ImagesListRouter {

  weak var viewController: ImagesListViewController?
 
  // MARK: Navigation
  func navigateToImageDetailVc(_ imageModel: ImageModel) {
      if let imageDetailsVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageDetailsViewController") as? ImageDetailsViewController {
          imageDetailsVc.viewModel.imageModel = imageModel
          viewController?.navigationController?.pushViewController(imageDetailsVc, animated: true)
      }
  }
}
