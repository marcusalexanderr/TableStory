//
//  ViewController.swift
//  TableStory
//
//  Created by Alexander, Marcus J on 3/20/24.
//

import UIKit
import MapKit

//array objects of our data.
let data = [
    Item(name: "Student Recreation Center", neighborhood: "Downtown", desc: "Indoor", lat: 29.888765, long: -97.950776, imageName: "rec"),
    Item(name: "The Retreat", neighborhood: "Hyde Park", desc: "Blacktop", lat: 29.894748, long: -97.960970, imageName: "retreat"),
    Item(name: "Copper Beech", neighborhood: "Mueller", desc: "Blacktop", lat: 29.900624, long: -97.912694, imageName: "copper"),
    Item(name: "Gold's Gym", neighborhood: "UT", desc: "Indoor", lat: 29.885946, long: -97.923632, imageName: "golds"),
    Item(name: "San Marcos Activity Center", neighborhood: "Hyde Park", desc: "Indoor", lat: 29.884898, long: -97.932802, imageName: "activity")
   
]

struct Item {
    var name: String
    var neighborhood: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var theTable: UITableView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        let item = data[indexPath.row]
        cell?.textLabel?.text = item.name
        //Add image references
                      let image = UIImage(named: item.imageName)
                      cell?.imageView?.image = image
                      cell?.imageView?.layer.cornerRadius = 10
                      cell?.imageView?.layer.borderWidth = 5
                      cell?.imageView?.layer.borderColor = UIColor.white.cgColor
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let item = data[indexPath.row]
      performSegue(withIdentifier: "ShowDetailSegue", sender: item)
    
  }
    
    // add this function to original ViewController
          override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "ShowDetailSegue" {
                if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DetailViewController {
                    // Pass the selected item to the detail view controller
                    detailViewController.item = selectedItem
                }
            }
        }
        
            
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        theTable.delegate = self
        theTable.dataSource = self
       
        //set center, zoom level and region of the map
              let coordinate = CLLocationCoordinate2D(latitude: 29.884898, longitude: -97.932802)
              let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
              mapView.setRegion(region, animated: true)
              
           // loop through the items in the dataset and place them on the map
               for item in data {
                  let annotation = MKPointAnnotation()
                  let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
                  annotation.coordinate = eachCoordinate
                      annotation.title = item.name
                      mapView.addAnnotation(annotation)
                      }
    }


}

