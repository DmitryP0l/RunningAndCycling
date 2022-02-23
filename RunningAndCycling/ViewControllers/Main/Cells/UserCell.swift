//
//  AchievementTableViewCell.swift
//  RunningAndCycling
//
//  Created by lion on 5.02.22.
//

import UIKit

final class UserCell: UITableViewCell {
    
    static let identifier = "UserCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private let achievlabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
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
        containerView.addSubview(achievlabel)
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.bottom.equalToSuperview().inset(16)
            make.height.equalTo(60.0)
        }
        containerView.backgroundColor = .green
        
        achievlabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8.0)
            
            make.centerX.equalTo(containerView.snp.centerX)
            make.centerY.equalTo(containerView.snp.centerY)
            
        }
    }
    
}
