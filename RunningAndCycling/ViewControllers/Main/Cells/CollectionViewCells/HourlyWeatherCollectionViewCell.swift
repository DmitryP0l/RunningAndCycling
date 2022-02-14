//
//  HourlyWeatherCollectionViewCell.swift
//  RunningAndCycling
//
//  Created by lion on 5.02.22.
//

import UIKit
import SnapKit

final class HourlyWeatherCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HourlyWeatherCollectionViewCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
//    private let backgroundImageView: UIImageView = {
//        let view = UIImageView()
//        view.contentMode = .scaleAspectFit
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.clipsToBounds = true
//        view.image = UIImage(named: "image")
//        return view
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(containerView)
        //containerView.addSubview(backgroundImageView)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
//        backgroundImageView.snp.makeConstraints { make in
//            make.edges.equalTo(containerView.snp.edges).inset(4)
//        }
        containerView.backgroundColor = .red
    }
    
    
    
}
