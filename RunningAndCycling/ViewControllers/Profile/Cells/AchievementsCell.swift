//
//  ФchievementsCell.swift
//  RunningAndCycling
//
//  Created by lion on 15.02.22.
//

import UIKit

class AchievementsCell: UITableViewCell {
    
    static let identifier = "AchievementsCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()

    private let cupImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let achievementLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = .systemFont(ofSize: 22)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    private let progressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private let progressView: UIProgressView = {
        let view = UIProgressView(progressViewStyle: .default)
        view.trackTintColor = .gray
        view.progressTintColor = .blue
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(containerView)
        containerView.addSubview(cupImageView)
        containerView.addSubview(achievementLabel)
        containerView.addSubview(progressLabel)
        containerView.addSubview(progressView)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        containerView.backgroundColor = .green
        
        cupImageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(12.0)
            make.centerY.equalTo(containerView.snp.centerY)
            make.height.equalTo(60)
            make.width.equalTo(cupImageView.snp.height)
        }
        cupImageView.backgroundColor = .red
        DispatchQueue.main.async {
            self.cupImageView.layer.cornerRadius = self.cupImageView.frame.height/2
            self.cupImageView.clipsToBounds = true
        }
        
        achievementLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12.0)
            make.centerX.equalTo(containerView.snp.centerX)
        }
        achievementLabel.backgroundColor = .red
        achievementLabel.text = "самый быстрый конь"
        
        progressLabel.snp.makeConstraints { make in
            make.top.equalTo(achievementLabel.snp.bottom).offset(4.0)
            make.leading.equalTo(cupImageView.snp.trailing).offset(8.0)
        }
        progressLabel.backgroundColor = .red
        progressLabel.text = "пройдено 123 из 321"
        
        progressView.snp.makeConstraints { make in
            make.top.equalTo(progressLabel.snp.bottom).offset(8.0)
            make.centerX.equalTo(containerView.snp.centerX)
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalTo(6.0)
        }
        progressView.setProgress(0, animated: false)
//        let progress = Progress()
//        progressView.observedProgress = progress
        
        
    }

}
