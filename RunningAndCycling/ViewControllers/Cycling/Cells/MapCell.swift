//
//  MapCell.swift
//  RunningAndCycling
//
//  Created by lion on 22.02.22.
//

import UIKit

class MapCell: UITableViewCell {

  static let identifier = "MapCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
     //   contentView.addSubview(containerView)
    }

}
