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
    
    private var dataSource: [RunningCellType] = [.timer, .distabce, .speed]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "пробежка"
        setupView()
        setupTableView()
    }

    private func setupView() {
        view.addSubview(containerButtonView)
        containerButtonView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(80.0)
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
        switch dataSource[indexPath.row] {
            
        case .timer:
            let cell = tableView.dequeueReusableCell(withIdentifier: TimerCell.identifier, for: indexPath) as! TimerCell
            return cell
        case .distabce:
            let cell = tableView.dequeueReusableCell(withIdentifier: DistanceCell.identifier, for: indexPath) as! DistanceCell
            return cell
        case .speed:
            let cell = tableView.dequeueReusableCell(withIdentifier: SpeedCell.identifier, for: indexPath) as! SpeedCell
            return cell
        }
    }
    
    
}
