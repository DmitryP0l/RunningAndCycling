//
//  ViewController.swift
//  RunningAndCycling
//
//  Created by lion on 2.02.22.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private var dataSource:[CellType] = []
    private enum CellType {
        case achievUser(user: UserModel)
        case currentWeather(day: WeatherModel)
        case hourly(hours: [WeatherModel])
        case advice(advice: AdviceModel)
        //case lastActivity //добавить скорее всего табличку в ячейку с последними треками
    }
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "главная страница"
        setupTableView()
        
        APIManager.getWeather { [weak self] response in
            guard let self = self, let response = response else { return }
            self.dataSource.append(.currentWeather(day: response.current))
            self.dataSource.append(.hourly(hours: response.hourly))
            self.tableView.reloadData()
        }
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.isUserInteractionEnabled = true
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)
        tableView.register(CurrentWeatherCell.self, forCellReuseIdentifier: CurrentWeatherCell.identifier)
        tableView.register(HourlyWeatherCell.self, forCellReuseIdentifier: HourlyWeatherCell.identifier)
        tableView.register(AdviceCell.self, forCellReuseIdentifier: AdviceCell.identifier)
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

        case .achievUser(user: let user):
            let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as! UserCell
            cell.textLabel?.text = "ачивки юзера, ссыль на профиль, может динамическая ячейка"
            return cell
        case .currentWeather(day: let day):
            let cell = tableView.dequeueReusableCell(withIdentifier: CurrentWeatherCell.identifier, for: indexPath) as! CurrentWeatherCell
            cell.setupWith(currentWeather: day)
            return cell
        case .hourly(hours: let hours):
            let cell = tableView.dequeueReusableCell(withIdentifier: HourlyWeatherCell.identifier, for: indexPath) as! HourlyWeatherCell
            cell.setupWith(hourlyWeatherModel: hours)
            return cell
        case .advice(advice: let advice):
            let cell = tableView.dequeueReusableCell(withIdentifier: AdviceCell.identifier, for: indexPath) as! AdviceCell
            cell.textLabel?.text = "рекомендации по погоде"
            return cell

        }
    }
}

