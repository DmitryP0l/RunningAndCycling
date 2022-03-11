//
//  TimerCell.swift
//  RunningAndCycling
//
//  Created by lion on 21.02.22.
//

import UIKit

class TimerCell: UITableViewCell {

    static let identifier = "TimerCell"
    
    var model: TimerCellModel? {
        didSet {
            basicTimerLabel.text = model?.currentTimer
            setAllRunTimeLabel.text = model?.setTimer
            allTimeLeftLabel.text = model?.leftAllTimer
            setIntervalRunTimeLabel.text = model?.setInterval
            intervalLeftLabel.text = model?.leftInterval
        }
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10.0
        view.clipsToBounds = true
        return view
    }()
    
    private let basicTimerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 40.0)
        label.numberOfLines = 1
        label.textColor = .black
        return label
    }()
    
    private let setAllRunTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18.0)
        label.numberOfLines = 1
        label.textColor = .lightGray
        return label
    }()
    
    private let setAllRunTimeButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "gearshape")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(setAllRunTimeAction), for: .touchUpInside)
        return button
    }()
    
    private let allTimeLeftLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18.0)
        label.numberOfLines = 1
        label.textColor = .lightGray
        return label
    }()
    
    private let setIntervalRunTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 18.0)
        label.numberOfLines = 1
        label.textColor = .lightGray
        return label
    }()
    
    private let setIntervalRunTimeButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "gearshape")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(setIntervalRunTimeAction), for: .touchUpInside)
        return button
    }()
    
    private let intervalLeftLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18.0)
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
        containerView.addSubview(basicTimerLabel)
        containerView.addSubview(setAllRunTimeLabel)
        containerView.addSubview(setAllRunTimeButton)
        containerView.addSubview(allTimeLeftLabel)
        containerView.addSubview(setIntervalRunTimeLabel)
        containerView.addSubview(setIntervalRunTimeButton)
        containerView.addSubview(intervalLeftLabel)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        basicTimerLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(12.0)
        }
        basicTimerLabel.text = "00:23:45"
        
        setAllRunTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(basicTimerLabel.snp.bottom).offset(4.0)
            make.centerX.equalToSuperview()
        }
        setAllRunTimeLabel.text = "заданное время: 00:40"
        
        setAllRunTimeButton.snp.makeConstraints { make in
            make.centerY.equalTo(setAllRunTimeLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(12.0)
            make.height.equalTo(setAllRunTimeLabel.snp.height)
            make.width.equalTo(setAllRunTimeButton.snp.height)
        }
        
        allTimeLeftLabel.snp.makeConstraints { make in
            make.top.equalTo(setAllRunTimeLabel.snp.bottom).offset(4.0)
            make.leading.trailing.equalToSuperview().inset(12.0)
        }
        allTimeLeftLabel.text = "осталось 00:16:15 / потрачено"
        
        setIntervalRunTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(allTimeLeftLabel.snp.bottom).offset(4.0)
            make.centerX.equalToSuperview()
        }
        setIntervalRunTimeLabel.text = "заданный интервал: 00:10"
        
        setIntervalRunTimeButton.snp.makeConstraints { make in
            make.centerY.equalTo(setIntervalRunTimeLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(12.0)
            make.height.equalTo(setIntervalRunTimeLabel.snp.height)
            make.width.equalTo(setIntervalRunTimeButton.snp.height)
        }
        
        intervalLeftLabel.snp.makeConstraints { make in
            make.top.equalTo(setIntervalRunTimeLabel.snp.bottom).offset(4.0)
            make.leading.trailing.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(8.0)
        }
        intervalLeftLabel.text = "интервал через 00:03:45"
        
    }
    
    @objc func setAllRunTimeAction() {
        print("setAll")
    }
    
    @objc func setIntervalRunTimeAction() {
        print("setInterv")
    }

}
