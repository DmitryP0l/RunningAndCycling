//
//  RunningViewController.swift
//  RunningAndCycling
//
//  Created by lion on 2.02.22.
//

import UIKit
import MapKit
import CoreLocation

class RunningViewController: UIViewController {
    
    var timerLabel: UILabel = UILabel()
    var distanceLabel: UILabel = UILabel()
    var speedLabel: UILabel = UILabel()
    
    let userDefaults = UserDefaults.standard
    
    var coorList: [CLLocationCoordinate2D] = []
    var locationList: [[CLLocation]] = []
    var distance: Double = 0.0
    let manager = CLLocationManager()
    
    private let containerButtonView: ButtonView = {
        let view = ButtonView()
        view.backgroundColor = .clear
        return view
    }()
    private let tableView = UITableView()
    private let mapController = MapViewController()
    
    //timer
    private var timer = Timer()
    private var count: Int = 0
    private var timerCounting: Bool = false
    
    func playPause() {
        if timerCounting {
            timerCounting = false
            timer.invalidate()
            manager.stopUpdatingLocation()
        } else {
            timerCounting = true
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
            manager.startUpdatingLocation()
        }
    }
    
    @objc func timerCounter() {
        count += 1
        let time = secondsToHoursMinSec(seconds: count)
        let timerString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        timerLabel.text = timerString
    }
    
    func secondsToHoursMinSec(seconds: Int) -> (Int, Int, Int) {
        return((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        
        return timeString
    }
    
    func stopReset() {
        let alert = UIAlertController(title: "stop?", message: "что делать-то будем теперь?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: { (_) in
        }))
        alert.addAction(UIAlertAction(title: "reset", style: .default, handler: { (_) in
            self.count = 0
            self.timer.invalidate()
            self.timerLabel.text = "00 : 00 : 00"
            self.distanceLabel.text = "0.00"
            self.speedLabel.text = "0.00"
            
        }))
        alert.addAction(UIAlertAction(title: "save", style: .destructive, handler:{ (_) in
            
            var savedTranings: [SavedTraining] = []
            if let data = self.userDefaults.value(forKey: "trainings") as? Data {
                let trainings = try? PropertyListDecoder().decode(Array<SavedTraining>.self, from: data)
                if let trainings = trainings {
                    savedTranings = trainings
                }
            }
            
            let traning = SavedTraining(date: Date(), time: self.count, distance: self.distance)
            savedTranings.append(traning)
            self.timer.invalidate()
            self.count = 0
            self.userDefaults.set(try? PropertyListEncoder().encode(savedTranings), forKey: "trainings")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    

    private var timerList: [TimerCellModel] = [
        TimerCellModel(currentTimer: "00 : 00 : 00", setTimer: "set timer 01.20", leftAllTimer: "left 00.34.04", setInterval: "set interval 00.15", leftInterval: "left 00.14.04")
    ]
    
    private var distancionList: [DistancionCellModel] = [
        DistancionCellModel(currentDistancion: "2.220 m", setDistance: "set distance 2.300 m", leftDistance: "left distance 0.080 m")]
    
    private var speedList: [SpeedCellModel] = [
        SpeedCellModel(currentSpeed: "7.23km/h", averageSpeed: "average speed 4.93 km/h")
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
        containerButtonView.backgroundColor = .clear
        containerButtonView.delegate = self
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(containerButtonView.snp.top)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundView = UIImageView(image: UIImage(named: "backgroung"))
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
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            timerLabel = cell.basicTimerLabel
            return cell
            
        case .distabce:
            let cell = tableView.dequeueReusableCell(withIdentifier: DistanceCell.identifier, for: indexPath) as! DistanceCell
            if let model = item.dataModel as? DistancionCellModel {
                cell.model = model
            }
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            distanceLabel = cell.currentDistanceLAbel
            return cell
            
        case .speed:
            let cell = tableView.dequeueReusableCell(withIdentifier: SpeedCell.identifier, for: indexPath) as! SpeedCell
            if let model = item.dataModel as? SpeedCellModel {
                cell.model = model
            }
            speedLabel = cell.currentSpeedLabel
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        }
    }
}


extension RunningViewController: ButtonViewDelegate {
    func playButton() {
        playPause()
        manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.requestAlwaysAuthorization()
    }
    
    func stopButton() {
        timerCounting = false
        timer.invalidate()
        manager.stopUpdatingLocation()
        stopReset()
    }
    
    func locationButton() {
     present(mapController, animated: true, completion: nil)
    }
    
    func currentSpeed() {
        let speed = manager.location?.speed
        if let speed = speed {
            speedLabel.text = String(speed)
        }
        
    }
}

extension RunningViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        if coorList.isEmpty {
            distance += 0.0
        } else {
            let locationStart = CLLocation(latitude: (coorList.last?.latitude)!, longitude: (coorList.last?.longitude)!)
            
            let locationCurrent = CLLocation(latitude: (locations.first?.coordinate.latitude)!, longitude: (locations.first?.coordinate.longitude)!)
            
            distance += locationStart.distance(from: locationCurrent)
        }
        
        coorList.append(CLLocationCoordinate2D(latitude: (locations.first?.coordinate.latitude)!, longitude: (locations.first?.coordinate.longitude)!))
        
        locationList.append(locations)
        mapController.coorList = self.coorList
        distanceLabel.text = String(format: "%.2f", distance)
        
        currentSpeed()
        
    }
}


//picker

//
//private var textField = UITextField()
//private let hours = [1...23]
//private let minutes = [1...59]
//private let seconds = [1...59]
//private let pickerView = UIPickerView()
//
//
//override func viewDidLoad() {
//    super.viewDidLoad()
//    pickerView.delegate = self
//    pickerView.dataSource = self
//    textField.inputView = pickerView
//    textField.textAlignment = .center
//}
//
//}
//
//extension MapViewController: UIPickerViewDelegate, UIPickerViewDataSource {
//
//func numberOfComponents(in pickerView: UIPickerView) -> Int {
//    return 3
//}
//
//
//func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//    return minutes.count
//}
//
//func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//    return "\(minutes[row])" // но это хрень полная походу
//}
//
//func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//    textField.text = "\(minutes[row])"
//    textField.resignFirstResponder()
//}
//
