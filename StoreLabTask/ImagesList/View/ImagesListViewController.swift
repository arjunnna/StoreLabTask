//
//  ImagesListVc.swift
//  StoreLabTask
//
//  Created by Mallikarjuna on 05/03/2023.
//

import UIKit
import DZNEmptyDataSet
import MBProgressHUD

protocol ImagesListViewControllerOutput {
    func getImagesList(_ pageId: String)
}

protocol ImagesListViewControllerInput {
    func showImagesLists(_ imagesList: [ImageModel], error: Error?)
}

class ImagesListViewController: UIViewController, ImagesListViewControllerInput {

    @IBOutlet weak var collectionView: UICollectionView!

    var output: ImagesListInteractor?
    var router: ImagesListRouter?
    var viewModel = ImageListViewModel()
    var page: Int = 0
    var isPageRefreshing:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        ImagesListConfiguarator().configure(viewController: self)
        self.collectionView.accessibilityIdentifier = ImagesListIdentifiers.collectionView.rawValue
        self.getImagesList()
        // Do any additional setup after loading the view.
    }

    func getImagesList() {
        isPageRefreshing = true
        MBProgressHUD.showAdded(to: self.view, animated: true)
        output?.getImagesList("\(page)")
    }

    func showImagesLists(_ imagesList: [ImageModel], error: Error?) {
        self.isPageRefreshing = false
        MBProgressHUD.hide(for: self.view, animated: true)
        if error != nil {
            self.showErrorAlert()
        } else {
            self.viewModel.updateImagesList(imagesList)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    /// Show error message and try again
    func showErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "Error Occured while fetching the Images. Please try again", preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "Try Again", style: .default) { _ in
            self.getImagesList()
        }
        okBtn.accessibilityIdentifier = "okButtonIdentifier"
        alert.addAction(okBtn)
        self.navigationController?.present(alert, animated: true)
    }
}

extension ImagesListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.collectionView.contentOffset.y >= (self.collectionView.contentSize.height - self.collectionView.bounds.size.height)) {
            if !isPageRefreshing {
                page = page + 1
                self.getImagesList()
            }
        }
    }
}


extension ImagesListViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    // MARK: - DZNEmptyDataSetSource

    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let title = "No Images Found"
        let attributedString = NSAttributedString(string: title, attributes: [.font: UIFont.theSansArabicPlain(size: FontSize.large.value),
                                                                              .foregroundColor: UIColor.lightGray
        ])
        return attributedString
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let description = "Error occured while fetching the images. Please try Again"
        let attributedString = NSAttributedString(string: description, attributes: [.font: UIFont.theSansArabicPlain(size: FontSize.medium.value),
                                                                                    .foregroundColor: UIColor.lightGray
        ])
        return attributedString
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "placeHolderIcon")
    }

    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> NSAttributedString! {
        let attributedString = NSAttributedString(string: "Try Again", attributes: [.font: UIFont.theSansArabicBold(size: FontSize.large.value),
                                                                                    .foregroundColor: UIColor.black
        ])
        return attributedString
    }

    // MARK: - DZNEmptyDataSetDelegate
    
    func emptyDataSetDidTapButton(_ scrollView: UIScrollView!) {
       
    }
}
