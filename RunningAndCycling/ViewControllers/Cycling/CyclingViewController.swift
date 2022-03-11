//
//  CyclingViewController.swift
//  RunningAndCycling
//
//  Created by lion on 2.02.22.
//

import UIKit
import SnapKit

class CyclingViewController: UIViewController {
    
    private let tableView = UITableView()
    
    private let containerButtonView: ButtonView = {
        let view = ButtonView()
        return view
    }()
    
    private var parametersCyclingList: [ParametersCellModel] = [
        ParametersCellModel(currentSpeed: "10.10 km/h", averageSpeed: "5.5 km/h", distance: "22.2 km", basicTimer: "1.11.11 h")
    ]
    
    private var dataSource: [cyclingCellItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "велопрогулка"
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
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MapCell.self, forCellReuseIdentifier: MapCell.identifier)
        tableView.register(ParametersCell.self, forCellReuseIdentifier: ParametersCell.identifier)
    }
    
    private func createItems() {
        dataSource.append(cyclingCellItem(type: .map, dataModel: nil))
        for parameters in parametersCyclingList {
            dataSource.append(cyclingCellItem(type: .parameters, dataModel: parameters))
        }
    }
}


extension CyclingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let height = view.frame.size.height / 2
        return CGFloat(height)
        
       // return UITableView.automaticDimension
    } 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = dataSource[indexPath.row]
        switch item.type {
        case .map:
            let cell = tableView.dequeueReusableCell(withIdentifier: MapCell.identifier, for: indexPath) as! MapCell
            return cell
            
        case .parameters:
            let cell = tableView.dequeueReusableCell(withIdentifier: ParametersCell.identifier, for: indexPath) as! ParametersCell
            if let model = item.dataModel as? ParametersCellModel {
                cell.model = model
            }
            return cell
        }
    }
    
    
}
