//
//  DistanceCell.swift
//  RunningAndCycling
//
//  Created by lion on 21.02.22.
//

import UIKit

class DistanceCell: UITableViewCell {

    static let identifier = "DistanceCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10.0
        view.clipsToBounds = true
        return view
    }()
    
    private let currentDistanceLAbel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 40)
        label.numberOfLines = 1
        label.textColor = .black
        return label
    }()
    
    private let setDistanceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 1
        label.textColor = .lightGray
        return label
    }()
    
    private let setDistanceButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "gearshape")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(setDistanceAction), for: .touchUpInside)
        return button
    }()
    
    private let distanceLeftLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 1
        label.textColor = .lightGray
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
        containerView.addSubview(currentDistanceLAbel)
        containerView.addSubview(setDistanceLabel)
        containerView.addSubview(setDistanceButton)
        containerView.addSubview(distanceLeftLabel)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        currentDistanceLAbel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(12.0)
        }
        currentDistanceLAbel.text = "1.720 m"
        
        setDistanceLabel.snp.makeConstraints { make in
            make.top.equalTo(currentDistanceLAbel.snp.bottom).inset(4.0)
            make.centerX.equalToSuperview()
        }
        setDistanceLabel.text = "заданная дистанция: 2.500 m"
        
        setDistanceButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(12.0)
            make.centerY.equalTo(setDistanceLabel.snp.centerY)
            make.height.width.equalTo(setDistanceLabel.snp.height)
        }
        
        distanceLeftLabel.snp.makeConstraints { make in
            make.top.equalTo(setDistanceLabel.snp.bottom).inset(-4.0)
            make.leading.trailing.equalToSuperview().inset(12.0)
            make.bottom.equalToSuperview().inset(8.0)
        }
        distanceLeftLabel.text = "осталось: 0.780 m / дистанция пройдена"
    }
    
    @objc func setDistanceAction() {
        print("set")
    }
}
