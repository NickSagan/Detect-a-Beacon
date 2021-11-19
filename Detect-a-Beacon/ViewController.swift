//
//  ViewController.swift
//  Detect-a-Beacon
//
//  Created by Nick Sagan on 18.11.2021.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var distanceReader: UILabel!
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        
        view.backgroundColor = .gray
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    
//we only start scanning for beacons when we have permission and if the device is able to do so
                    
                    startScanning()
                }
            }
        }
    }
    
    func startScanning() {
        let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 123, minor: 456, identifier: "MyBeacon")

        locationManager?.startMonitoring(for: beaconRegion)
        locationManager?.startRangingBeacons(in: beaconRegion)
    }
    
    func update(distance: CLProximity) {
        UIView.animate(withDuration: 1) {
            switch distance {
            case .unknown:
                self.view.backgroundColor = UIColor.gray
                self.distanceReader.text = "UNKNOWN"

            case .far:
                self.view.backgroundColor = UIColor.blue
                self.distanceRdistanceReadereading.text = "FAR"

            case .near:
                self.view.backgroundColor = UIColor.orange
                self.distanceReader.text = "NEAR"

            case .immediate:
                self.view.backgroundColor = UIColor.red
                self.distanceReader.text = "RIGHT HERE"
                
            @unknown default:
                self.view.backgroundColor = .black
                self.distanceReader.text = "WHOA!"
            }
        }
    }
}

