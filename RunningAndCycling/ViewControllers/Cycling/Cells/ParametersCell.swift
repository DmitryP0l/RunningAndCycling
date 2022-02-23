//
//  ParametersCell.swift
//  RunningAndCycling
//
//  Created by lion on 22.02.22.
//

import UIKit

class ParametersCell: UITableViewCell {

   static let identifier = "ParametersCell"
    
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    private let titleCurrentSpeedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.text = "текущая скорость"
        return label
    }()
    private let currentSpeedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 40)
        label.textColor = .black
        return label
    }()
    
    private let titleAverageSpeed: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.text = "средний темп"
        return label
    }()
    
    private let averageSpeed: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 28)
        label.textColor = .gray
        return label
    }()
    
    
    private let titleDistanceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.text = "пройденная дистанция"
        return label
    }()
    
    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 40)
        label.textColor = .black
        return label
    }()
    
    private let titleBasicTimer: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.text = "время заезда"
        return label
    }()
    
    private let basicTimer: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 40)
        label.textColor = .black
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
        containerView.addSubview(titleCurrentSpeedLabel)
        containerView.addSubview(currentSpeedLabel)
        containerView.addSubview(titleAverageSpeed)
        containerView.addSubview(averageSpeed)
        containerView.addSubview(titleDistanceLabel)
        containerView.addSubview(distanceLabel)
        containerView.addSubview(titleBasicTimer)
        containerView.addSubview(basicTimer)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleCurrentSpeedLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8.0)
            make.leading.trailing.equalToSuperview().inset(12.0)
        }
        
        currentSpeedLabel.snp.makeConstraints { make in
            make.top.equalTo(titleCurrentSpeedLabel.snp.bottom).offset(4.0)
            make.leading.trailing.equalToSuperview().inset(12.0)
        }
        currentSpeedLabel.text = "15.6 km/h"
        
        titleAverageSpeed.snp.makeConstraints { make in
            make.top.equalTo(currentSpeedLabel.snp.bottom).offset(8.0)
            make.leading.trailing.equalToSuperview().inset(12.0)
        }
        
        averageSpeed.snp.makeConstraints { make in
            make.top.equalTo(titleAverageSpeed.snp.bottom).offset(4.0)
            make.leading.trailing.equalToSuperview().inset(12.0)
        }
        averageSpeed.text = "12.4 km/h"
        
        titleDistanceLabel.snp.makeConstraints { make in
            make.top.equalTo(averageSpeed.snp.bottom).offset(8.0)
            make.leading.trailing.equalToSuperview().inset(12.0)
        }
        
        distanceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleDistanceLabel.snp.bottom).offset(4.0)
            make.leading.trailing.equalToSuperview().inset(12.0)
        }
        distanceLabel.text = "24.6 km"
        
        titleBasicTimer.snp.makeConstraints { make in
            make.top.equalTo(distanceLabel.snp.bottom).offset(8.0)
            make.leading.trailing.equalToSuperview().inset(12.0)
        }
        
        basicTimer.snp.makeConstraints { make in
            make.top.equalTo(titleBasicTimer.snp.bottom).offset(4.0)
            make.leading.trailing.equalToSuperview().inset(12.0)
            make.bottom.equalToSuperview().inset(8.0)
        }
        basicTimer.text = "01.24.56"
    }

}
