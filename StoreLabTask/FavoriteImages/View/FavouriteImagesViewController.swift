//
//  FavouriteImagesVc.swift
//  StoreLabTask
//
//  Created by Mallikarjuna on 05/03/2023.
//

import UIKit
import DZNEmptyDataSet
import MBProgressHUD

protocol FavouriteImagesViewControllerOutput {
    func getFavouriteImagesList()
}

protocol FavouriteImagesViewControllerInput {
    func showFavouritesImagesLists(_ imagesList: [FavouriteImages], error: Error?)
}

class FavouriteImagesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var output: FavouriteImagesInteractor?
    var router: FavouriteImagesRouter?
    var viewModel = FavouriteImagesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favourites"
        self.collectionView.accessibilityIdentifier = FavouriteImagesIdentifiers.collectionView.rawValue
        self.tabBarItem.accessibilityIdentifier = FavouriteImagesIdentifiers.tabBar.rawValue
        FavouriteImagesConfiguarator().configure(viewController: self)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getFavouriteImages()
    }
    
    func getFavouriteImages() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        output?.getFavouriteImagesList()
    }
    
    /// Show error message and try again
    func showErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "Error Occured while fetching the Favourite Images. Please try again", preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "Try Again", style: .default) { [weak self] _ in
            self?.getFavouriteImages()
        }
        okBtn.accessibilityIdentifier = FavouriteImagesIdentifiers.errorOkButton.rawValue
        alert.addAction(okBtn)
        self.navigationController?.present(alert, animated: true)
    }
}

// MARK: - FavouriteImagesViewControllerInput
extension FavouriteImagesViewController: FavouriteImagesViewControllerInput {
    func showFavouritesImagesLists(_ imagesList: [FavouriteImages], error: Error?) {
        self.viewModel.imagesList = imagesList
        MBProgressHUD.hide(for: self.view, animated: true)
        self.collectionView.reloadData()
    }
}

extension FavouriteImagesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesCollectionCell.reuseIdentifier, for: indexPath) as? ImagesCollectionCell {
            cell.imageUrl = self.viewModel.getImageUrl(indexPath.row)
            cell.layoutIfNeeded()
            return cell
        } else {
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.collectionView.frame.self.width / 2) - 10
        return CGSize(width: width, height: width)
    }

    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        router?.navigateToImageDetailVc(self.viewModel.getImageModel(indexPath.row))
    }
}

extension FavouriteImagesViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    // MARK: - DZNEmptyDataSetSource

    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let title = "No Favourties Found"
        let attributedString = NSAttributedString(string: title, attributes: [.font: UIFont.theSansArabicPlain(size: FontSize.large.value),
                                                                              .foregroundColor: UIColor.lightGray
        ])
        return attributedString
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let description = "To Add Images to favourite Go to Images List and select an image and click on add to favourites button"
        let attributedString = NSAttributedString(string: description, attributes: [.font: UIFont.theSansArabicPlain(size: FontSize.medium.value),
                                                                                    .foregroundColor: UIColor.lightGray
        ])
        return attributedString
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "emptyPlaceholderIcon")
    }

    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> NSAttributedString! {
        let attributedString = NSAttributedString(string: "Add to Favourites", attributes: [.font: UIFont.theSansArabicBold(size: FontSize.large.value),
                                                                                    .foregroundColor: UIColor.black
        ])
        return attributedString
    }


    // MARK: - DZNEmptyDataSetDelegate
    
    func emptyDataSetDidTapButton(_ scrollView: UIScrollView!) {
        self.tabBarController?.selectedIndex = 0
    }
}
