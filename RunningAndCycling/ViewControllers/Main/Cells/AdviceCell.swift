//
//  AdviceCell.swift
//  RunningAndCycling
//
//  Created by lion on 6.02.22.
//

import UIKit
import SnapKit

class AdviceCell: UITableViewCell {

    static let identifier = "AdviceCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
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
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.bottom.equalToSuperview().inset(16)
            make.height.equalTo(60.0)
        }
        containerView.backgroundColor = .red
    }

    
}
