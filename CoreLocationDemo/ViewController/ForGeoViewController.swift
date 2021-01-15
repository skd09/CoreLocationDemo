//
//  ForGeoViewController.swift
//  CoreLocationDemo
//
//  Created by Work on 2021-01-14.
//

import UIKit
import CoreLocation

class ForGeoViewController : UIViewController {
    
    let geocoder = CLGeocoder()
    
    @IBOutlet weak var tfCountry: UITextField!
    @IBOutlet weak var tfCity: UITextField!
    @IBOutlet weak var tfStreet: UITextField!
    @IBOutlet weak var btnFetchCoordinate: UIButton!
    @IBOutlet weak var lblLocation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func onFetchCoordinateClicked(_ sender: Any) {
        guard let country = tfCountry.text else {return}
        guard let city = tfCity.text else {return}
        guard let street = tfStreet.text else {return}
        
        
        print("\(country), \(city), \(street)")
        
        self.getLocation(address: "\(country), \(city), \(street)")
    }
    
}

extension ForGeoViewController{
    
    func getLocation(address : String){
        geocoder.geocodeAddressString(address, completionHandler: { (placemark, error) in
            self.processGeoResponse(withPlacemarks: placemark, error: error)
        })
    }
    
    func processGeoResponse(withPlacemarks placemarks : [CLPlacemark]?, error : Error?){
        if error != nil{
            lblLocation.text = "We are unable to get the coordinates"
        }else{
            var location : CLLocation?
            
            if let placemark = placemarks, placemarks!.count > 0{
                location = placemark.first?.location
            }
            
            if let location = location{
                lblLocation.text = "\(location.coordinate.latitude), \(location.coordinate.longitude)"
            }else{
                lblLocation.text = "Coordinates not found"
            }
        }
    }
    
}
