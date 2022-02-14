//
//  ViewController.swift
//  RunningAndCycling
//
//  Created by lion on 2.02.22.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private var dataSource:[CellType] = [CellType.achievUser, CellType.currentWeather, CellType.hourly, CellType.advice]
    private enum CellType {
        case achievUser
        case currentWeather
        case hourly
        case advice
        //case lastActivity //добавить скорее всего табличку в ячейку
    }
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "главная страница"
        setupTableView()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.isUserInteractionEnabled = true
        tableView.register(AchievementCell.self, forCellReuseIdentifier: AchievementCell.identifier)
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource[indexPath.row] {

        case .achievUser:
            let cell = tableView.dequeueReusableCell(withIdentifier: AchievementCell.identifier, for: indexPath) as! AchievementCell
            cell.textLabel?.text = "ачивки юзера, ссыль на профиль, может динамическая ячейка"
            return cell
        case .currentWeather:
            let cell = tableView.dequeueReusableCell(withIdentifier: CurrentWeatherCell.identifier, for: indexPath) as! CurrentWeatherCell
            return cell
        case .hourly:
            let cell = tableView.dequeueReusableCell(withIdentifier: HourlyWeatherCell.identifier, for: indexPath) as! HourlyWeatherCell
            cell.isUserInteractionEnabled = true
            return cell
        case .advice:
            let cell = tableView.dequeueReusableCell(withIdentifier: AdviceCell.identifier, for: indexPath) as! AdviceCell
            cell.textLabel?.text = "рекомендации по погоде"
            return cell
   
        }
        
        
    }
    
    
}

