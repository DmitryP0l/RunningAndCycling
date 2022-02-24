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
    
    private var dataSource: [CyclingCellType] = [.map, .parameters]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "велопрогулка"
        setupView()
        setupTableView()
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
}


extension CyclingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let height = view.frame.size.height / 2
        return CGFloat(height)
        
//        return UITableView.automaticDimension
    } 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource[indexPath.row] {
            
        case .map:
            let cell = tableView.dequeueReusableCell(withIdentifier: MapCell.identifier, for: indexPath) as! MapCell
            return cell
        case .parameters:
            let cell = tableView.dequeueReusableCell(withIdentifier: ParametersCell.identifier, for: indexPath) as! ParametersCell
            return cell
        }
    }
    
    
}
