//
//  DetailImageVc.swift
//  FlickerSearch
//
//  Created by Mohamed on 3/11/21.
//

import UIKit
import Kingfisher

class DetailImageVc: UIViewController {
    
    //MARK: - Outlet
    @IBOutlet weak var imageShow: UIImageView!
    @IBOutlet weak var imageTitleLabel: UILabel!
    @IBOutlet weak var scrolView: UIScrollView!
    @IBOutlet weak var idLabel: UILabel!
    
    
    //MARK: - properties
    
    var imageViewShow = ""
    var titleImage = ""
    var idLabelTitle = ""
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    //MARK:- Class Methods
    
    func setUpUI() {
        imageShow.image = UIImage(named: imageViewShow)
        ImageCache.default.clearMemoryCache()
        setupImage(image:imageViewShow)
        navigationController?.isNavigationBarHidden = false
        imageTitleLabel.text = titleImage
        imageShow.layer.cornerRadius = 14
        scrolView.maximumZoomScale = 4
        scrolView.minimumZoomScale = 1
        scrolView.delegate = self
        idLabel.text = "ID:\(idLabelTitle)"
    }
    
    func setupImage(image:String) {
        let url = URL(string: image)
        imageShow.kf.indicatorType = .activity
        imageShow.kf.setImage(with: url)
    }
}

extension DetailImageVc: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageShow
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > 1 {
            if let image = imageShow.image {
                let ratioW = imageShow.frame.width / image.size.width
                let ratioH = imageShow.frame.height / image.size.height
                
                let ratio = ratioW < ratioH ? ratioW : ratioH
                let newWidth = image.size.width * ratio
                let newHeight = image.size.height * ratio
                let conditionLeft = newWidth*scrollView.zoomScale > imageShow.frame.width
                let left = 0.5 * (conditionLeft ? newWidth - imageShow.frame.width : (scrollView.frame.width - scrollView.contentSize.width))
                let conditioTop = newHeight*scrollView.zoomScale > imageShow.frame.height
                
                let top = 0.5 * (conditioTop ? newHeight - imageShow.frame.height : (scrollView.frame.height - scrollView.contentSize.height))
                
                scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
            }
        }
        else {
            scrollView.contentInset = .zero
        }
    }
}
