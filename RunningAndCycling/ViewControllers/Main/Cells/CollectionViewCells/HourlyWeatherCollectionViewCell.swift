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
        view.backgroundColor = .clear
        return view
    }()
    
    private let hourLabel: UILabel = {
        let label = UILabel()
         label.textAlignment = .center
         label.textColor = .black
         label.numberOfLines = 1
         label.font = .systemFont(ofSize: 20)
         return label
    }()
    
    private let weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let tempLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
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
        
        
        hourLabel.snp.makeConstraints { make in
            make.bottom.equalTo(weatherIcon.snp.top).inset(-4.0)
            make.leading.trailing.equalToSuperview().inset(8.0)
        }
        
        weatherIcon.snp.makeConstraints { make in
            make.centerX.equalTo(containerView.snp.centerX)
            make.centerY.equalTo(containerView.snp.centerY)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(weatherIcon.snp.width)
        }
        
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherIcon.snp.bottom).offset(4.0)
            make.centerX.equalTo(containerView.snp.centerX)
        }
    
    }
    
    func setupWith(hoursWeather: WeatherModel) {
        hourLabel.text = hoursWeather.time
        weatherIcon.image = UIImage(systemName: hoursWeather.systemIconNameString)
        tempLabel.text = hoursWeather.temperature
    }
    
}






