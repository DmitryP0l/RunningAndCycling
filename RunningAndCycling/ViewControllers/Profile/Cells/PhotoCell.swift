//
//  PhotoCell.swift
//  RunningAndCycling
//
//  Created by lion on 15.02.22.
//

import UIKit

class PhotoCell: UITableViewCell {
    
    static let identifier = "PhotoCell"
    
    var model: String? {
        didSet {
            if let model = model {
                photoImageView.image = UIImage(named: model)
            }
        }
    }
    
    private let photoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func setupView() {
        addSubview(photoImageView)
        photoImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(16.0)
            make.width.equalToSuperview().multipliedBy(0.3)
            make.height.equalTo(photoImageView.snp.width)
            make.centerX.equalToSuperview()
        }

        DispatchQueue.main.async {
            self.photoImageView.layer.cornerRadius = self.photoImageView.frame.height/2
            self.photoImageView.clipsToBounds = true
        }
        
        photoImageView.backgroundColor = .red
    }
    
    
    
}
