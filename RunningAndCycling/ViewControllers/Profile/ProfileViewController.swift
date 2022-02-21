//
//  ProfileVC.swift
//  RunningAndCycling
//
//  Created by lion on 3.02.22.
//


import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    

    
    private var achievList: [AchievementsCellModel] = [
        AchievementsCellModel(icon: "cup.and.saucer.fill", title: "самый быстрый", progressTitle: "скоро дотянем", progress: 10),
        AchievementsCellModel(icon: "cup.and.saucer.fill", title: "самый быстрый", progressTitle: "скоро дотянем", progress: 10),
        AchievementsCellModel(icon: "cup.and.saucer.fill", title: "самый быстрый", progressTitle: "скоро дотянем", progress: 10),
        AchievementsCellModel(icon: "cup.and.saucer.fill", title: "самый быстрый", progressTitle: "скоро дотянем", progress: 10),
        AchievementsCellModel(icon: "cup.and.saucer.fill", title: "самый быстрый", progressTitle: "скоро дотянем", progress: 10),
        AchievementsCellModel(icon: "cup.and.saucer.fill", title: "самый быстрый", progressTitle: "скоро дотянем", progress: 10)]
    
    private var dataSource: [ProfileCellItem] = []
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        navigationItem.title = "Профиль"
        setupTableView()
        createItems()
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
        tableView.register(StatisticCell.self, forCellReuseIdentifier: StatisticCell.identifier)
        tableView.register(AchievementsCell.self, forCellReuseIdentifier: AchievementsCell.identifier)
    }
    
    
    private func createItems() {
        dataSource.append(ProfileCellItem(type: .photo, dataModel: "photoprofile"))
        dataSource.append(ProfileCellItem(type: .name, dataModel: "Дмитрий Полетаев bastig"))
        dataSource.append(ProfileCellItem(type: .statistics, dataModel: nil))
        for achiev in achievList {
            dataSource.append(ProfileCellItem(type: .achievements, dataModel: achiev))
        }
    }
   
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch dataSource[indexPath.row].type {
        case .statistics:
            return CGFloat(150.0)
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = dataSource[indexPath.row]
        
        switch item.type {
        case .photo:
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCell.identifier, for: indexPath) as! PhotoCell
            
            if let model = item.dataModel as? String {
                cell.model = model
            }
            cell.isUserInteractionEnabled = false
            return cell
            
        case .name:
            let cell = tableView.dequeueReusableCell(withIdentifier: NameCell.identifier, for: indexPath) as! NameCell
            
            if let model = item.dataModel as? String {
                cell.model = model
            }
            cell.isUserInteractionEnabled = false
            return cell
            
        case .statistics:
            let cell = tableView.dequeueReusableCell(withIdentifier: StatisticCell.identifier, for: indexPath) as! StatisticCell
            return cell

        case .achievements:
            let cell = tableView.dequeueReusableCell(withIdentifier: AchievementsCell.identifier, for: indexPath) as! AchievementsCell
            
            if let model = item.dataModel as? AchievementsCellModel {
                cell.model = model
            }
            cell.selectionStyle = .none
            return cell
        }
    }
}
