//
//  ViewController.swift
//  RunningAndCycling
//
//  Created by lion on 2.02.22.
//


import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    private let tableView = UITableView()
    
    private var dataSource: [MainCellType] = []

    private var latestList: [LatestCellModel] = [
        LatestCellModel(date: "12.10.22", time: "время тренировки: 1:53:40", speed: "средняя скорость: 5.23 km/h", distance: "пройденная дистанция: 7.34 km"),
        LatestCellModel(date: "12.10.22", time: "02:34:57", speed: "5.36 km/h", distance: "12 km"),
        LatestCellModel(date: "12.10.22", time: "02:34:57", speed: "5.36 km/h", distance: "12 km"),
        LatestCellModel(date: "12.10.22", time: "02:34:57", speed: "5.36 km/h", distance: "12 km"),
        LatestCellModel(date: "12.10.22", time: "02:34:57", speed: "5.36 km/h", distance: "12 km")
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "главная страница"
        setupTableView()
        setupCell()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.isUserInteractionEnabled = true
        tableView.register(CurrentWeatherCell.self, forCellReuseIdentifier: CurrentWeatherCell.identifier)
        tableView.register(HourlyWeatherCell.self, forCellReuseIdentifier: HourlyWeatherCell.identifier)
        tableView.register(LatestCell.self, forCellReuseIdentifier: LatestCell.identifier)
    }
    
    private func setupCell() {
        APIManager.getWeather { [weak self] response in
            guard let self = self, let response = response else { return }
            self.dataSource.append(.currentWeather(day: response.current))
            self.dataSource.append(.hourly(hours: response.hourly))
            self.createLatest() //стремное решение, но работает
            self.tableView.reloadData()
        }
    }
    
    private func createLatest() {
        for latest in latestList {
            dataSource.append(MainCellType.latest(latest: latest))
        }
    }
    
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch dataSource[indexPath.row] {
        case .hourly(hours: _):
            return CGFloat(150.0)
            
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource[indexPath.row] {

        case .currentWeather(day: let day):
            let cell = tableView.dequeueReusableCell(withIdentifier: CurrentWeatherCell.identifier, for: indexPath) as! CurrentWeatherCell
            cell.setupWith(currentWeather: day)
            return cell
        case .hourly(hours: let hours):
            let cell = tableView.dequeueReusableCell(withIdentifier: HourlyWeatherCell.identifier, for: indexPath) as! HourlyWeatherCell
            cell.setupWith(hourlyWeatherModel: hours)
            return cell
        case .latest(latest: let latest):
            let cell = tableView.dequeueReusableCell(withIdentifier: LatestCell.identifier, for: indexPath) as! LatestCell
            cell.setupWith(model: latest)
            return cell
        }
    }
}

