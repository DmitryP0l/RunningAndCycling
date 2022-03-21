//
//  WeatherTableViewCell.swift
//  RunningAndCycling
//
//  Created by lion on 3.02.22.
//

import UIKit

final class CurrentWeatherCell: UITableViewCell {

    static let identifier = "CurrentWeatherCell"
    
 //MARK: - Create UIView
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
//        view.layer.borderWidth = 2.0
//        view.layer.borderColor = UIColor.red.cgColor
        view.layer.shadowRadius = 15.0
        view.layer.shadowColor = UIColor.white.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .zero
        return view
    }()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "backImage")
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.3
        return imageView
    }()
    
    private let weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "sun.dust")
        return imageView
    }()
    
    private let windIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "wind")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    
    private let currentTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 24)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    private let currentFellTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 32)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    private let tempDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "По ощущениям: "
        label.textColor = .blue
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    private let windDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    private let weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = .systemFont(ofSize: 16)
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
    
    //MARK: - Setup UIView
    private func setupView() {
        contentView.addSubview(containerView)
        
        containerView.addSubview(backgroundImageView)
        containerView.addSubview(weatherDescriptionLabel)
        containerView.addSubview(weatherIcon)
        containerView.addSubview(windIcon)
        containerView.addSubview(currentTempLabel)
        containerView.addSubview(currentFellTempLabel)
        containerView.addSubview(tempDescriptionLabel)
        containerView.addSubview(windDescriptionLabel)
        containerView.addSubview(weatherDescriptionLabel)
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        weatherIcon.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.equalTo(weatherIcon.snp.width)
            make.top.leading.equalToSuperview().inset(8.0)
        }
        
        currentTempLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(8.0)
            make.leading.equalTo(weatherIcon.snp.trailing).offset(8.0)
        }
        
        
        currentFellTempLabel.snp.makeConstraints { make in
            make.top.equalTo(currentTempLabel.snp.bottom).offset(4.0)
            make.leading.equalTo(currentTempLabel.snp.leading)
            make.trailing.equalTo(currentTempLabel.snp.trailing)
        }
        
      
        
        tempDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(currentFellTempLabel.snp.bottom)
            make.leading.equalTo(currentFellTempLabel.snp.leading)
            make.trailing.equalTo(currentFellTempLabel.snp.trailing)
        }
        
        windDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(tempDescriptionLabel.snp.bottom).offset(8.0)
            make.trailing.equalTo(tempDescriptionLabel.snp.trailing)
        }
        
        windIcon.snp.makeConstraints { make in
            make.trailing.equalTo(windDescriptionLabel.snp.leading).inset(-4.0)
            make.height.equalTo(windDescriptionLabel.snp.height)
            make.width.equalTo(windIcon.snp.height).multipliedBy(1.5)
            make.centerY.equalTo(windDescriptionLabel.snp.centerY)
        }
        
        weatherDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherIcon.snp.bottom).offset(8.0)
            make.trailing.leading.bottom.equalToSuperview().inset(8.0)
            make.height.equalTo(80)
            
        }
    }
    
    func setupWith(currentWeather: WeatherModel) {
        currentTempLabel.text = "temp: \(currentWeather.temperature)"
        currentFellTempLabel.text = currentWeather.fellsLikeTemperature
        weatherDescriptionLabel.text = currentWeather.weatherDescription
        windDescriptionLabel.text = "\(currentWeather.windSpeed), направление: \(currentWeather.windDirectionString)"
        weatherIcon.image = UIImage(systemName: currentWeather.systemIconNameString) 
        
    }
}
