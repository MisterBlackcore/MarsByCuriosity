//
//  CameraRollCollectionViewCell.swift
//  MarsByCuriosity
//
//  Created by Anton Shkuray on 14.07.22.
//

import UIKit

final class CameraRollCollectionViewCell: UICollectionViewCell {
    //MARK: - Elements
    private let photoImageView: CachingImageView = {
        let imageView = CachingImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    //MARK: - View configuration
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addPhotoImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addPhotoImageView() {
        self.addSubview(photoImageView)
        photoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4).isActive = true
    }
    
    //MARK: - Flow functions
    func configureCell(with imageUrlString: String?) {
        guard let imageUrlString = imageUrlString, let imageUrl = URL(string: imageUrlString) else {
            return
        }
        photoImageView.loadImage(from: imageUrl)
    }
}
