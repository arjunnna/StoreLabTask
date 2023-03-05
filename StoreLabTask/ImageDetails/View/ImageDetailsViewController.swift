//
//  ImageDetailsVc.swift
//  StoreLabTask
//
//  Created by Mallikarjuna on 05/03/2023.
//

import UIKit

/// This is used to show the Image Details
class ImageDetailsViewController: UIViewController {
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var addToFavouriteBtn: UIButton!
    @IBOutlet weak var holderView: UIView!
    
    var viewModel = ImageDetailsViewModel()
    
    var isAddedToFavourite: Bool = false
    var isFromFavourites: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Image Details"
        self.setUpView()
        self.updateUI()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    func setUpView() {
        self.addToFavouriteBtn.layer.cornerRadius = 16
        self.addToFavouriteBtn.clipsToBounds = true
        self.detailImageView.layer.cornerRadius = 16
        self.detailImageView.clipsToBounds = true
        self.holderView.layer.cornerRadius = 16
        self.holderView.clipsToBounds = true
        self.detailsLabel.font = UIFont.theSansArabicBold(size: FontSize.large.value)
        self.addToFavouriteBtn.titleLabel?.font = UIFont.theSansArabicBold(size: FontSize.large.value)
        self.tabBarController?.tabBar.isHidden = true
        self.addToFavouriteBtn.accessibilityIdentifier = ImageDetailIdentifiers.addToFavouriteButton.rawValue
        self.detailsLabel.accessibilityIdentifier = ImageDetailIdentifiers.detailLabel.rawValue
        self.detailImageView.accessibilityIdentifier = ImageDetailIdentifiers.detailImage.rawValue
        let backBtn = UIBarButtonItem(image: UIImage(named: "backIcon"), style: .plain, target: self, action: #selector(backBtnAction(_ :)))
        backBtn.accessibilityIdentifier = ImageDetailIdentifiers.backButton.rawValue
        self.navigationItem.leftBarButtonItem  = backBtn
    }
    
    func updateUI() {
        self.detailsLabel.text = viewModel.getImageTitle()
        if let url = viewModel.getImageUrl() {
            self.downloadImage(url)
        }
        self.addToFavouriteBtn.setTitle(viewModel.getAddToFavouriteTitle(), for: .normal)
        if let imageId = self.viewModel.getImageId(),
           self.viewModel.isAlreadyAdded(imageId: imageId) {
            self.isAddedToFavourite = true
        }
    }
    
    /// This is used to Download the Image
    func downloadImage(_ url: URL) {
        DispatchQueue.main.async {[weak self] in
            self?.detailImageView.showSkeleton()
            self?.detailImageView.startAnimating()
        }
        self.detailImageView.image = nil
        DispatchQueue.global(qos: .default).async {[weak self] in
            self?.detailImageView.af_setImage(withURL: url, runImageTransitionIfCached: true) {imageResponse in
                DispatchQueue.main.async {
                    self?.detailImageView.hideSkeleton()
                    self?.detailImageView.stopAnimating()
                    if let imageData = imageResponse.data {
                        self?.detailImageView.image = UIImage(data: imageData)
                    } else if imageResponse.error != nil {
                        /// Set default placeholder Image If the ImageDownload failes
                        self?.detailImageView.image = UIImage(named: "placeHolderIcon")
                    }
                }
            }
        }
    }
    
    @IBAction func addToFavouriteButtonAction(_ sender: UIButton) {
        self.updateImageDetails()
    }

    func updateImageDetails() {
        if let imageModel = self.viewModel.imageModel {
            if isAddedToFavourite {
                self.addImageToFavourite(imageModel)
            } else {
                self.removeImageFromFavourite(imageModel)
            }
        }
    }

    func addImageToFavourite(_ imageModel: ImageModel) {
        if let imageId = imageModel.imageId {
            viewModel.removeImageFromFavoritesList(imageId: imageId, completion: { [weak self] isSuccess in
                if isSuccess {
                    self?.showAlert(isAdding: false)
                } else {
                    self?.showErrorAlert()
                }
            })
        }
    }

    func removeImageFromFavourite(_ imageModel: ImageModel) {
        viewModel.addImageToFavoriteList(imageModel, completion: {  [weak self] isSuccess in
            if isSuccess {
                self?.showAlert(isAdding: true)
            } else {
                self?.showErrorAlert()
            }
        })
    }
    
    func showAlert(isAdding: Bool) {
        let message = isAdding ? "Successfully added to your favourite list" :  "Successfully removed from your favourite list"
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "Ok", style: .default) { _ in
            if self.isFromFavourites {
                self.navigationController?.popViewController(animated: true)
            }
        }
        if isAdding {
            self.isAddedToFavourite = true
            self.addToFavouriteBtn.setTitle("Remove From Favourites", for: .normal)
        } else {
            self.isAddedToFavourite = false
            self.addToFavouriteBtn.setTitle("Add to Favourites", for: .normal)
        }
        okBtn.accessibilityIdentifier = ImageDetailIdentifiers.okButton.rawValue
        alert.addAction(okBtn)
        self.navigationController?.present(alert, animated: true)
    }

    func showErrorAlert() {
        let message = "There is error Occured While updating. Please try again"
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "Try Again", style: .default) {[weak self] _ in
            self?.updateImageDetails()
        }
        alert.addAction(okBtn)
        self.navigationController?.present(alert, animated: true)
    }
}
