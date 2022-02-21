//
//  StatisticCollectionCell.swift
//  RunningAndCycling
//
//  Created by lion on 16.02.22.
//

import UIKit

class StatisticCollectionCell: UICollectionViewCell {
    
    var model: StatisticCellModel? {
        didSet {
            imageView.image = UIImage(systemName: model?.icon ?? "takeoutbag.and.cup.and.straw")
            descriptionLabel.text = model?.title
            resultLabel.text = model?.result
        }
    }
    
    static let identifier = "StatisticCollectionCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16)
        label.textColor = .darkGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(resultLabel)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(4.0)
        }
        
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.equalTo(imageView.snp.width)
        }
        imageView.backgroundColor = .yellow
        DispatchQueue.main.async {
            self.imageView.layer.cornerRadius = self.imageView.frame.width / 2
            self.clipsToBounds = true
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8.0)
            make.leading.trailing.equalToSuperview().inset(12.0)
            make.centerX.equalToSuperview()
        }
       
        descriptionLabel.text = "средняя  скорость за все время"
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8.0)
            make.centerX.equalToSuperview()
        }
       
        resultLabel.text = "8,5 км/ч"
    }
    
}
