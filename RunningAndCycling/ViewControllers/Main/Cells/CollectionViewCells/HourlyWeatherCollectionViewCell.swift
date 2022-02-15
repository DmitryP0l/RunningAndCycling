//
//  HourlyWeatherCollectionViewCell.swift
//  RunningAndCycling
//
//  Created by lion on 5.02.22.
//

import UIKit
import SnapKit

final class HourlyWeatherCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HourlyWeatherCollectionViewCell"
    
    //MARK: - create UIView
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private let hourLabel: UILabel = {
        let label = UILabel()
         label.textAlignment = .center
         label.textColor = .green
         label.numberOfLines = 1
         label.font = .systemFont(ofSize: 20)
         return label
    }()
    
    private let weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "sun.min")
        return imageView
    }()
    
    private let tempLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.textColor = .green
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 25)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(containerView)
        containerView.addSubview(hourLabel)
        containerView.addSubview(weatherIcon)
        containerView.addSubview(tempLabel)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        containerView.backgroundColor = .green
        
        hourLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8.0)
            make.leading.trailing.equalToSuperview().inset(8.0)
        }
        hourLabel.text = " 12.00"
        hourLabel.backgroundColor = .red
        
        weatherIcon.snp.makeConstraints { make in
            make.centerX.equalTo(containerView.snp.centerX)
            make.centerY.equalTo(containerView.snp.centerY)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(weatherIcon.snp.width)
        }
        weatherIcon.backgroundColor = .red
        
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherIcon.snp.bottom).offset(8.0)
            make.centerX.equalTo(containerView.snp.centerX)
        }
        tempLabel.text = " +12º"
        tempLabel.backgroundColor = .red
        
    }
    
    func setupWith(hoursWeather: WeatherModel) {
        hourLabel.text = hoursWeather.time
        weatherIcon.image = UIImage(systemName: hoursWeather.systemIconNameString)
        tempLabel.text = hoursWeather.temperature
    }
    
}






