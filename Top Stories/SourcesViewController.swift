//
//  ViewController.swift
//  Top Stories
//
//  Created by Alan Reyes on 1/5/22.
//

import UIKit

class SourcesViewController: UITableViewController {

    var sources = [[String: String]] ()
    let apiKey = "d45229539c5d4c6ea40599abe7ec48c8"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "News Sources"
        let query = "https://newsapi.org/vl/sources?language=en&country=us&apiKey=\(apiKey)"
        
        let url = URL(string: query)!
        if let data = try? Data(contentsOf: url) {
            if let json = try? JSON (data: data), json["status"] == "ok" {
                parse(json: json)
            } else {
                showError()
            }
        } else {
            showError()
        }
    }
    func parse (json: JSON) {
        for result in json["sources"].arrayValue {
            let id = result ["id"].stringValue
            let name = result["name"].stringValue
            let desciption = result["description"].stringValue
            let source = ["id": id, "name": name, "desciption": desciption]
            sources.append(source)
        }
        tableView.reloadData()
    }
    
    func showError() {
        let alert = UIAlertController (title: "Loading Error", message: "There was a proglem loading the news feed" , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}

