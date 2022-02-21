//
//  CyclingViewController.swift
//  RunningAndCycling
//
//  Created by lion on 2.02.22.
//

import UIKit
import SnapKit

class CyclingViewController: UIViewController {
    
    private let containerButtonView: ButtonView = {
        let view = ButtonView()
        return view 
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "велопрогулка"
        setupView()
    }

    
    private func setupView() {
        view.addSubview(containerButtonView)
        containerButtonView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
           // make.top.equalTo(self.view.snp.bottomMargin).offset(-60)
            make.height.equalTo(80.0)
        }
        containerButtonView.backgroundColor = .red
        
    }
}
