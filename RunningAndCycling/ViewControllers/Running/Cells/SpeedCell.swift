//
//  SpeedCell.swift
//  RunningAndCycling
//
//  Created by lion on 21.02.22.
//

import UIKit

class SpeedCell: UITableViewCell {

    static let identifier = "SpeedCell"
    
    var model: SpeedCellModel? {
        didSet {
            currentSpeedLabel.text = model?.currentSpeed
            averageRunPace.text = model?.averageSpeed
        }
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10.0
        view.clipsToBounds = true
        return view
    }()
    
    private let currentSpeedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 40)
        label.numberOfLines = 1
        label.textColor = .black
        return label
    }()
    
    private let averageRunPace: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 32)
        label.numberOfLines = 1
        label.textColor = .darkGray
        return label
    }()
    
    private let runPaceChart: LineChartView = {
        let view = LineChartView()
        view.layer.cornerRadius = 10.0
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
        containerView.addSubview(currentSpeedLabel)
        containerView.addSubview(averageRunPace)
        containerView.addSubview(runPaceChart)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        currentSpeedLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(12.0)
        }
        
        averageRunPace.snp.makeConstraints { make in
            make.top.equalTo(currentSpeedLabel.snp.bottom).offset(12.0)
            make.centerX.equalToSuperview()
        }
        
        runPaceChart.snp.makeConstraints { make in
            make.top.equalTo(averageRunPace.snp.bottom).offset(8.0)
            make.leading.trailing.equalToSuperview().inset(12.0)
            make.bottom.equalToSuperview().inset(8.0)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        runPaceChart.backgroundColor = .clear
    }
    
    
    


}
