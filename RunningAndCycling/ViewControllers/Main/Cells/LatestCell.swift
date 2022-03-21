//
//  LatestCell.swift
//  RunningAndCycling
//
//  Created by lion on 18.03.22.
//

import UIKit
import SnapKit


class LatestCell: UITableViewCell {
    
    static let identifier = "LatestCell"
    
//    var model: LatestCellModel? {
//        didSet {
//            dateLabel.text = model?.date
//            timeLabel.text = model?.time
//            speedLabel.text = model?.speed
//            distanceLabel.text = model?.distance
//        }
//    }

    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.backgroundColor = .clear
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 10
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    private let speedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(containerView)
        containerView.addSubview(dateLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(speedLabel)
        containerView.addSubview(distanceLabel)
        
        containerView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.top.equalToSuperview().inset(16.0)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(4.0)
            make.top.equalToSuperview().inset(2.0)
        }
        dateLabel.text = "23.04.2022"
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(4.0)
            make.leading.equalToSuperview().inset(4.0)
        }
        
        speedLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(4.0)
            make.leading.equalToSuperview().inset(4.0)
        }

        
        distanceLabel.snp.makeConstraints { make in
            make.top.equalTo(speedLabel.snp.bottom).offset(4.0)
            make.leading.equalToSuperview().inset(4.0)
            make.bottom.equalToSuperview().inset(8.0)
        }
    }

    func setupWith(model: LatestCellModel) {
        dateLabel.text = model.date
        timeLabel.text = model.time
        speedLabel.text = model.speed
        distanceLabel.text = model.distance
    }

    
    
}
