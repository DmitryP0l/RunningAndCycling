//
//  StatRunCell.swift
//  RunningAndCycling
//
//  Created by lion on 16.02.22.
//

import UIKit

class StatisticCell: UITableViewCell {
    
    static let identifier = "StatRunCell"
    
    private var dataSource: [StatisticCellModel] = [ StatisticCellModel(icon: "cup.and.saucer", title: "средняя скорость", result: "120 км/ч"), StatisticCellModel(icon: "cup.and.saucer", title: "средняя скорость", result: "120 км/ч"), StatisticCellModel(icon: "cup.and.saucer", title: "средняя скорость", result: "120 км/ч"), StatisticCellModel(icon: "cup.and.saucer", title: "средняя скорость", result: "120 км/ч"), StatisticCellModel(icon: "cup.and.saucer", title: "средняя скорость", result: "120 км/ч"), StatisticCellModel(icon: "cup.and.saucer", title: "средняя скорость", result: "120 км/ч"), StatisticCellModel(icon: "cup.and.saucer", title: "средняя скорость", result: "120 км/ч"), StatisticCellModel(icon: "cup.and.saucer", title: "средняя скорость", result: "120 км/ч"), StatisticCellModel(icon: "cup.and.saucer", title: "средняя скорость", result: "120 км/ч"), StatisticCellModel(icon: "cup.and.saucer", title: "средняя скорость", result: "120 км/ч") ]
    
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(StatisticCollectionCell.self, forCellWithReuseIdentifier: StatisticCollectionCell.identifier)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
    }
    
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension StatisticCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width / 3
        let height = 150.0
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StatisticCollectionCell.identifier, for: indexPath) as! StatisticCollectionCell
        cell.model = dataSource[indexPath.row]
        cell.backgroundColor = .clear
        return cell
    }
}
