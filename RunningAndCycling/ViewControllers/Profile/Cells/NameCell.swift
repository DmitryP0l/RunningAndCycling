//
//  NameCell.swift
//  RunningAndCycling
//
//  Created by lion on 15.02.22.
//

import UIKit

class NameCell: UITableViewCell {
    
    static let identifier = "NameCell"
    
    var model: String? {
        didSet {
            if let model = model {
                nameLabel.text = model
            }
        }
    }
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 44)
        label.numberOfLines = 0
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
        contentView.addSubview(nameLabel)

        nameLabel.snp.makeConstraints { make in
           
            make.top.bottom.equalToSuperview().inset(8.0)
            make.leading.trailing.equalToSuperview().inset(16.0)
            
        }
    }
}
