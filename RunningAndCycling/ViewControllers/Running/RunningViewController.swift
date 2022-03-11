//
//  RunningViewController.swift
//  RunningAndCycling
//
//  Created by lion on 2.02.22.
//

import UIKit

class RunningViewController: UIViewController {
    
    private let tableView = UITableView()
    
    private let containerButtonView: ButtonView = {
        let view = ButtonView()
        return view
    }()
    
    private var timerList: [TimerCellModel] = [
        TimerCellModel(currentTimer: "0.45.56", setTimer: "set timer 01.20", leftAllTimer: "left 00.34.04", setInterval: "set interval 00.15", leftInterval: "left 00.14.04")
    ]
    
    private var distancionList: [DistancionCellModel] = [
        DistancionCellModel(currentDistancion: "2.220 m", setDistance: "set distance 2.300 m", leftDistance: "left distance 0.080 m")]
    
    private var speedList: [SpeedCellModel] = [
        SpeedCellModel(currentSpeed: "7.23km/h", averageSpeed: "average speed 5.23km/h")
    ]
    
    private var dataSource: [RunningCellItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "пробежка"
        setupView()
        setupTableView()
        createItems()
    }

    private func setupView() {
        view.addSubview(containerButtonView)
        containerButtonView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(70.0)
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(containerButtonView.snp.top)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TimerCell.self, forCellReuseIdentifier: TimerCell.identifier)
        tableView.register(DistanceCell.self, forCellReuseIdentifier: DistanceCell.identifier)
        tableView.register(SpeedCell.self, forCellReuseIdentifier: SpeedCell.identifier)
    }
    
    private func createItems() {
        for timer in timerList {
            dataSource.append(RunningCellItem(type: .timer, dataModel: timer))
        }
        
        for distance in distancionList {
            dataSource.append(RunningCellItem(type: .distabce, dataModel: distance))
        }
        for speed in speedList {
            dataSource.append(RunningCellItem(type: .speed, dataModel: speed))
        }
        
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension RunningViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let height = view.frame.size.height / 2
//        return CGFloat(height)
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = dataSource[indexPath.row]
        switch item.type {
            
        case .timer:
            let cell = tableView.dequeueReusableCell(withIdentifier: TimerCell.identifier, for: indexPath) as! TimerCell
            if let model = item.dataModel as? TimerCellModel {
                cell.model = model
            }
            return cell
            
        case .distabce:
            let cell = tableView.dequeueReusableCell(withIdentifier: DistanceCell.identifier, for: indexPath) as! DistanceCell
            if let model = item.dataModel as? DistancionCellModel {
                cell.model = model
            }
            return cell
            
        case .speed:
            let cell = tableView.dequeueReusableCell(withIdentifier: SpeedCell.identifier, for: indexPath) as! SpeedCell
            if let model = item.dataModel as? SpeedCellModel {
                cell.model = model
            }
            return cell
        }
    }
    

}
