//
//  ProfileVC.swift
//  RunningAndCycling
//
//  Created by lion on 3.02.22.
//


import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    
    private var dataSource: [ProfileCellType] = [.photo, .name, .achievements]
    
    private enum ProfileCellType {
        case photo
        case name
        case achievements
    }
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        navigationItem.title = "Профиль"
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.separatorStyle = .none
        tableView.register(PhotoCell.self, forCellReuseIdentifier: PhotoCell.identifier)
        tableView.register(NameCell.self, forCellReuseIdentifier: NameCell.identifier)
        tableView.register(AchievementsCell.self, forCellReuseIdentifier: AchievementsCell.identifier)
    }
    
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource[indexPath.row] {
        case .photo:
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCell.identifier, for: indexPath) as! PhotoCell
            cell.model = "photoprofile"
            cell.isUserInteractionEnabled = false
            return cell
            
        case .name:
            let cell = tableView.dequeueReusableCell(withIdentifier: NameCell.identifier, for: indexPath) as! NameCell
            cell.model = "просто имя"
            cell.isUserInteractionEnabled = false
            return cell
            
        case .achievements:
            let cell = tableView.dequeueReusableCell(withIdentifier: AchievementsCell.identifier, for: indexPath)
            return cell
        }
    }
    
    
}
