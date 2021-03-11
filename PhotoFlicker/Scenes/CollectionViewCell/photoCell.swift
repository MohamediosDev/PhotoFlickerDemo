//
//  photoCell.swift
//  FlickerSearch
//
//  Created by Mohamed on 3/10/21.
//

import UIKit
import Kingfisher


class photoCell: UICollectionViewCell {
    
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        photoImageView.layer.cornerRadius = 14
        KingfisherManager.shared.cache.clearMemoryCache()
        KingfisherManager.shared.cache.clearDiskCache()
        KingfisherManager.shared.cache.cleanExpiredDiskCache()

    }
    func configurecell(image:String) {
        
        let url = URL(string: image)
        photoImageView.kf.indicatorType = .activity
        let placeHolder = UIImage(named: "1")
        photoImageView.kf.setImage(with: url , placeholder: placeHolder)
        
        }

}
