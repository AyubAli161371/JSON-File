//
//  ViewController.swift
//  JSON
//
//  Created by - on 14/11/2021.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage


class ViewController: UIViewController {
    
    @IBOutlet weak var myTable: UITableView!
    
    
    var vegetableList = [[String:Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getJSONData()
        // Do any additional setup after loading the view.
    }
    
    func getJSONData()
    {
        let urlFile = "http://haritibhakti.com/jsondata/vegetables.json"
        Alamofire.request(urlFile).responseJSON { (response) in
            switch response.result
            {
            case .success(_):
                
                let jsondata = response.result.value as! [[String:Any]]?
                self.vegetableList = jsondata!
                self.myTable.reloadData()
                
            case .failure(let error):
                print("Error Occured \(error.localizedDescription)")
            }
        }
    }


}



extension ViewController: UITableViewDelegate,UITableViewDataSource
{
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return vegetableList.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = myTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
as! MyTableViewCell
    cell.myLabel.text = vegetableList[indexPath.row]["name"] as? String
    let urlImage = vegetableList[indexPath.row]["imagename"] as?String
    
    
    Alamofire.request(urlImage!).responseImage { (response) in
        if let image = response.result.value
        {
            DispatchQueue.main.async {
                cell.myImage.image = image
            }
        }
        
    }
    
    return cell
    
}
}

