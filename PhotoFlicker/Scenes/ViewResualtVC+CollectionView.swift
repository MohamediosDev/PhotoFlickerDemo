//
//  ViewResualtVC+CollectionView.swift
//  FlickerSearch
//
//  Created by Mohamed on 3/10/21.
//

import UIKit

extension ViewResultVc : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
   
    func setupCollectionView() {
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        photoCollectionView.register(UINib(nibName: "photoCell", bundle: nil), forCellWithReuseIdentifier: "photoCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
            let photo = photoModel?.photos?.photo?.count ?? 0
            return photo
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = photoCollectionView.dequeueReusableCell(withReuseIdentifier:"photoCell", for: indexPath) as! photoCell
        
        
        let photo = photoModel?.photos?.photo?[indexPath.item].urlM ?? ""
            
            cell.configurecell(image: photo)
            let text = photoModel?.photos?.photo?[indexPath.item].title
            cell.photoTitleLabel.text = text
            return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailImageVc") as! DetailImageVc
        let photo = photoModel?.photos?.photo?[indexPath.item].urlM ?? ""
        let text = photoModel?.photos?.photo?[indexPath.item].title ?? ""
        let Id = photoModel?.photos?.photo?[indexPath.item].id ?? ""

        vc.imageViewShow = photo
        vc.titleImage = text
        vc.idLabelTitle = Id
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.4865, height: self.view.frame.width * 0.45)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }
}
struct Alert {
    
    static func showBasicAlert(on vc: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async { vc.present(alert, animated: true) }
    }
}
