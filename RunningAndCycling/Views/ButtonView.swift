//
//  ButtonView.swift
//  RunningAndCycling
//
//  Created by lion on 16.02.22.
//

protocol ButtonViewDelegate: AnyObject {
    func playButton()
    func stopButton()
    func locationButton()
}

import UIKit

enum StateStopButton {
    case stop
    case save
}

enum StatePlayButton {
    case play
    case pause
    var imageName: String {
        switch self {
        case .play:
            return "play.circle"
        case .pause:
            return "pause.circle"
        }
    }
}

enum StateLocationButton {
    case selected
    case noSelected
    var imageName: String {
        switch self {
        case .selected:
            return "location.north.circle"
        case .noSelected:
            return "location.circle"
        }
    }
}

final class ButtonView: UIView {
    
    weak var delegate: ButtonViewDelegate?
    private var stateStopButton: StateStopButton = .stop
    private var statePlayButton: StatePlayButton = .play {
        didSet {
            playButton.setBackgroundImage(UIImage(systemName: statePlayButton.imageName), for: .normal)
        }
    }
    private var stateLocationButton: StateLocationButton = .noSelected {
        didSet {
            locationButton.setBackgroundImage(UIImage(systemName: stateLocationButton.imageName), for: .normal)
        }
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle")
        button.setBackgroundImage(image, for: .normal)
        button.addTarget(self, action: #selector(playPauseButtonAction), for: .touchUpInside)
        return button
    }()
    
    private let stopButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "stop.circle")
        button.setBackgroundImage(image, for: .normal)
        button.addTarget(self, action: #selector(stopButtonAction), for: .touchUpInside)
        return button
    }()
    
    private let locationButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "location.circle")
//        let imageSel = UIImage(systemName: "location.north.circle")
        button.setBackgroundImage(image, for: .normal)
//        button.setBackgroundImage(imageSel, for: .selected)
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
    
    @objc func playPauseButtonAction() {
        statePlayButton = statePlayButton == .play ? .pause : .play
        delegate?.playButton()
    }
    @objc func stopButtonAction() {
        statePlayButton = .play
    }
    
    @objc func locationButtonAction() {
        stateLocationButton = stateLocationButton == .noSelected ? .selected : .noSelected
    }
    
    private func setupView() {
        addSubview(containerView)
        containerView.addSubview(playButton)
        containerView.addSubview(stopButton)
        containerView.addSubview(locationButton)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        containerView.backgroundColor = .clear
        
        playButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(containerView.snp.height).multipliedBy(0.9)
            make.width.equalTo(playButton.snp.height)
        }
        
        stopButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(playButton.snp.leading).offset(-12)
            make.height.equalTo(containerView.snp.height).multipliedBy(0.7)
            make.width.equalTo(stopButton.snp.height)
        }
        
        locationButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(playButton.snp.trailing).offset(12)
            make.height.equalTo(containerView.snp.height).multipliedBy(0.7)
            make.width.equalTo(locationButton.snp.height)
        }
    }

}
