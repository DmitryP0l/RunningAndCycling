//
//  ButtonView.swift
//  RunningAndCycling
//
//  Created by lion on 16.02.22.
//

import UIKit

final class ButtonView: UIView {
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(playButtonAction), for: .touchUpInside)
        return button
    }()
    
    private let stopButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "stop.circle")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(stopButtonAction), for: .touchUpInside)
        return button
    }()
    
    private let locationButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "location.circle")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(locationButtonAction), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func playButtonAction() {
    }
    
    @objc func stopButtonAction() {
    }
    
    @objc func locationButtonAction() {
    }
    
    private func setupView() {
        addSubview(containerView)
        containerView.addSubview(playButton)
        containerView.addSubview(stopButton)
        containerView.addSubview(locationButton)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        containerView.backgroundColor = .green
        
        playButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(containerView.snp.height).multipliedBy(0.9)
            make.width.equalTo(playButton.snp.height)
        }
        playButton.backgroundColor = .red
        
        stopButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(playButton.snp.leading).offset(-12)
            make.height.equalTo(containerView.snp.height).multipliedBy(0.7)
            make.width.equalTo(stopButton.snp.height)
        }
        stopButton.backgroundColor = .white
        
        locationButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(playButton.snp.trailing).offset(12)
            make.height.equalTo(containerView.snp.height).multipliedBy(0.7)
            make.width.equalTo(locationButton.snp.height)
        }
        locationButton.backgroundColor = .white
    }

}
