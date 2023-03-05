//
//  ImagesCollectionCell.swift
//  StoreLabTask
//
//  Created by Mallikarjuna on 06/01/23.
//

import UIKit
import SkeletonView
import AlamofireImage
import Alamofire

/// This is used to display the Image in ImagesListViewController 
class ImagesCollectionCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ImagesCollectionCell"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var holderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.holderView.layer.cornerRadius = 16
        self.holderView.clipsToBounds = true
    }
    
    var imageUrl: URL? {
        didSet {
            if let url = imageUrl {
                DispatchQueue.main.async {[weak self] in
                    self?.imageView.showSkeleton()
                    self?.imageView.startSkeletonAnimation()
                }
                self.downloadImage(url)
            }
        }
    }

    func downloadImage(_ url: URL) {
        self.imageView.image = nil
        DispatchQueue.global(qos: .default).async {[weak self] in
            self?.imageView.af_setImage(withURL: url, runImageTransitionIfCached: true) { imageResponse in
                DispatchQueue.main.async {
                    self?.imageView.hideSkeleton()
                    self?.imageView.stopAnimating()
                    if let imageData = imageResponse.data {
                        self?.imageView.image = UIImage(data: imageData)
                    } else if imageResponse.error != nil {
                        /// Set default placeholder Image If the ImageDownload failes
                        self?.imageView.image = UIImage(named: "placeHolderIcon")
                    }
                }
            }
        }
    }
}
