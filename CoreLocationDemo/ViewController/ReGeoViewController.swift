//
//  ReGeoViewController.swift
//  CoreLocationDemo
//
//  Created by Work on 2021-01-14.
//

import UIKit
import CoreLocation

class ReGeoViewController : UIViewController {
    
    let geocoder = CLGeocoder()
    
    @IBOutlet weak var tfLatitude: UITextField!
    @IBOutlet weak var tfLongitude: UITextField!
    @IBOutlet weak var btnFetchAddress: UIButton!
    @IBOutlet weak var lblAddress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onFetchAddressClicked(_ sender: Any) {
        guard let latAsString = tfLatitude.text, let lat = Double(latAsString) else{return}
        guard let lngAsString = tfLongitude.text, let lng = Double(lngAsString) else{return}
        
        print("\(lat), \(lng)")
        
        self.getAddress(location: CLLocation(latitude: lat, longitude: lng))
    }
}

extension ReGeoViewController{
    func getAddress(location : CLLocation){
        geocoder.reverseGeocodeLocation(location, completionHandler: {(placemark, error) in
            self.processGeoResponse(withPlacemarks: placemark, error: error)
        })
    }
    
    func processGeoResponse(withPlacemarks placemarks : [CLPlacemark]?, error : Error?){
        if error != nil{
            lblAddress.text = "Unable to find the address."
        }else{
            
            if let placemarks = placemarks, let placemark = placemarks.first{
                let address = (placemark.locality! + ", " + placemark.administrativeArea! + ", " + placemark.country!)
                lblAddress.text = address
            }else{
                lblAddress.text = "Address is not found."
            }
        }
    }
}
