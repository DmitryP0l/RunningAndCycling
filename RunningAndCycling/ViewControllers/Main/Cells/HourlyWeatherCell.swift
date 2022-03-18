//
//  HourlyWeatherTableViewCell.swift
//  RunningAndCycling
//
//  Created by lion on 5.02.22.
//

import UIKit
import SnapKit

final class HourlyWeatherCell: UITableViewCell {
    
    static let identifier = "HourlyWeatherCell"

    private var dataSource:[WeatherModel] = []
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(HourlyWeatherCollectionViewCell.self, forCellWithReuseIdentifier: HourlyWeatherCollectionViewCell.identifier)
        return view
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.isUserInteractionEnabled = true
        view.clipsToBounds = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(containerView)
    containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.bottom.equalToSuperview().inset(4)
            make.height.equalTo(80.0)
        }
        containerView.backgroundColor = .red
    }
    
    private func setupCollectionView() {
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(containerView.snp.edges)
        }
    }
    
    func setupWith(hourlyWeatherModel: [WeatherModel]) {
        self.dataSource = hourlyWeatherModel
        collectionView.reloadData()
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension HourlyWeatherCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: 100, height: 150)
       }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCollectionViewCell.identifier, for: indexPath) as! HourlyWeatherCollectionViewCell
        cell.setupWith(hoursWeather: dataSource[indexPath.row])
        return cell
    }
    
}
