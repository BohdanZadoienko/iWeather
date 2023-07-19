//
//  ViewController.swift
//  iWeather
//
//  Created by Bohdan Zadoienko on 11.07.23.
//

import UIKit
import CoreLocation
import FloatingPanel
import AVFoundation

class ViewController: UIViewController, SearchViewControllerDelegate, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var videoLayer: UIView!
    @IBOutlet weak var currentLocationButton: UIButton!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherCodeLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var currentWeatherView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var weatherTableView: UITableView!
    
    let weatherAPI = WeatherAPI()
    let searchVC = SearchViewController()
    let panel = FloatingPanelController()
    let currentLocationManager = CLLocationManager()
    let playerLayer = AVPlayerLayer()
    
    var weatherData: WeatherData?
    
    var locations = [Location]()
    //    var dailyTime : [String] = []
    //    var dailyTempMax : [Double] = []
    //    var dailyTempMin : [Double] = []
    //    var dailyWeatherCode : [Int] = []
    //    var formatedDate : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCurrentUserLocation()
        searchVC.delegate = self
        panel.set(contentViewController: searchVC)
        panel.addPanel(toParent: self)
        self.currentLocationButton.addTarget(self, action: #selector(updateCurrentLocation), for: .touchUpInside)
        scrollView.layer.cornerRadius = 10
        weatherTableView.dataSource = self
        weatherTableView.layer.cornerRadius = 10
        weatherTableView.backgroundColor = UIColor(white: 0.1, alpha: 0.1)
        videoLayer.bringSubviewToFront(scrollView)
        
    }
    
    //MARK: - Set BackGroundVideo
    func playBackGroundVideo(videoPath: String){
        guard let path = Bundle.main.path(forResource: "\(videoPath)", ofType: "mp4") else {
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        self.playerLayer.player = player
        self.playerLayer.frame = self.view.bounds
        self.playerLayer.videoGravity = .resizeAspectFill
        self.playerLayer.repeatCount = .infinity
        self.videoLayer.layer.addSublayer(playerLayer)
        videoLayer.bringSubviewToFront(currentWeatherView)
        videoLayer.bringSubviewToFront(currentLocationButton)
        videoLayer.bringSubviewToFront(scrollView)
        player.actionAtItemEnd = .none
        NotificationCenter.default.addObserver(self, selector: #selector(rewindVide(notification:)), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        player.play()
        
    }
    
    @objc func rewindVide(notification: Notification){
        playerLayer.player?.seek(to: .zero)
    }
    
    
    @objc func updateCurrentLocation(){
        setCurrentUserLocation()
    }
    
    //MARK: - Setting Current User Location
    func setCurrentUserLocation(){
        CurrentLocationManager.shared.getCurrentLocation{ [weak self] location in
            DispatchQueue.main.async {
                guard let location = location else {
                    return
                }
                
                self?.fetchWeather(latitude: location.coordinate.latitude, longtitude: location.coordinate.longitude)
                CurrentLocationManager.shared.resolveCurrentLocationName(with: location){ [weak self] locationName in
                    self?.cityLabel.text = locationName
                }
            }
        }
    }
    
    //MARK: - Searching for places and fetching weahter
    func searchViewController(_ vc: SearchViewController, didSelectLocationWith location: Location) {
        self.cityLabel.text = location.city
        panel.move(to: .tip, animated: true)
        guard let latitude = location.coordinates?.latitude.magnitude,
              let longtitude = location.coordinates?.longitude.magnitude else {
            return
        }
        fetchWeather(latitude: latitude, longtitude: longtitude)
    }
    
    //MARK: - Fetching Weather
    func fetchWeather(latitude: Double, longtitude: Double){
        weatherAPI.fetchWeather(latitude: latitude, longitude: longtitude) { result in
            switch result {
            case .success(let weather):
                self.weatherData = weather
                DispatchQueue.main.async { [self] in
                    self.weatherTableView.reloadData()
                }
                self.updateUI()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func updateUI() {
        guard let weatherData = weatherData else { return }
        let currentTemp = Int(weatherData.currentWeather.temperature)
        let maxTemp = Int(weatherData.daily.temperature2MMax.first ?? 0)
        let minTemp = Int(weatherData.daily.temperature2MMin.first ?? 0)
        
        
        DispatchQueue.main.async { [self] in
            self.currentTempLabel.text = "\(currentTemp)°"
            self.maxTempLabel.text = "H:\(maxTemp)°"
            self.minTempLabel.text = "L:\(minTemp)°"
            if let weatherCode = WeatherCode(rawValue: weatherData.currentWeather.weathercode){
                self.weatherCodeLabel.text = weatherCode.description
                playBackGroundVideo(videoPath: weatherCode.videoPath)
                print("Get Path", weatherCode.videoPath)
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let count = weatherData?.daily.time.count else { return 0}
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        cell.dayLabel.text = weatherData?.daily.dateFormated[indexPath.row]
        cell.maxTempLabel.text = "H:\(Int(weatherData?.daily.temperature2MMax[indexPath.row] ?? 0))°"
        cell.minTempLabel.text = "L:\(Int(weatherData?.daily.temperature2MMin[indexPath.row] ?? 0))°"
        
        if let weatherCode = weatherData?.daily.weathercode {
            cell.iconImageView.image = UIImage(named: WeatherCode(rawValue: weatherCode[indexPath.row])?.iconPath ?? "")
        }
        cell.backgroundColor = UIColor(white: 0.1, alpha: 0.4)
        cell.dayLabel.textColor = .white
        cell.maxTempLabel.textColor = .white
        cell.minTempLabel.textColor = .white
        return cell
    }
    
}
