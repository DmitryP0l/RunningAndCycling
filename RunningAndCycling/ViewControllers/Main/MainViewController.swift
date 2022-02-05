//
//  ViewController.swift
//  RunningAndCycling
//
//  Created by lion on 2.02.22.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private var dataSource:[String] = ["", ""]
    
//    private var dataSource:[CellType] = []
//    private enum CellType {
//        case achievUser
//        case currentWeather
//        case hourly
//    }
    
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        tableView.register(CurrentWeatherCell.self, forCellReuseIdentifier: CurrentWeatherCell.identifier)
        tableView.register(HourlyWeatherCell.self, forCellReuseIdentifier: HourlyWeatherCell.identifier)
        tableView.register(AchievementCell.self, forCellReuseIdentifier: AchievementCell.identifier)
    }
    
    
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        switch dataSource[indexPath.row] {
//
//        case .achievUser:
//            let cell = tableView.dequeueReusableCell(withIdentifier: AchievementCell.identifier, for: indexPath) as! AchievementCell
//            return cell
//        case .currentWeather:
//            let cell = tableView.dequeueReusableCell(withIdentifier: CurrentWeatherCell.identifier, for: indexPath) as! CurrentWeatherCell
//            return cell
//        case .hourly:
//            let cell = tableView.dequeueReusableCell(withIdentifier: HourlyWeatherCell.identifier, for: indexPath) as! HourlyWeatherCell
//            return cell
//    default:
//        return UITableViewCell()
//        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: HourlyWeatherCell.identifier, for: indexPath) as! HourlyWeatherCell
                return cell
        
        
    }
    
    
}

