//
//  HomeViewController.swift
//  NY_Time
//
//  Created by MEHUL PANCHAL on 17/11/18.
//  Copyright © 2018 MEHUL PANCHAL. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {

    var rootArray : NSMutableArray! = nil
    var imageCache = NSMutableDictionary()
    var resultDetail : Result!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        self.tableView.tableFooterView = UIView()
        
        self.fetchData()
    }
    
    func fetchData() {
        
        let urlString = baseURLString + popularArticals
        
        guard let urlRequest = URL(string: urlString)  else {
            return
        }
        
        let activity = UIActivityIndicatorView(style: .gray)
        activity.center = self.tableView.center
        activity.startAnimating()
        self.tableView.addSubview(activity)
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else{
                activity.stopAnimating()
                return
            }
            
            do{
                
                if let jsonDic = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary{
                   // print(jsonDic)
                    
                   self.rootArray = ResponseParser.sharedInstance.apiResponse(jsonDic: jsonDic)
                    
                    DispatchQueue.main.async {
                        self.title = "NY Times Most Popular"
                        self.tableView.reloadData()
                        activity.stopAnimating()

                    }
                    
                }
                
            }catch let jsonError{
                print("Error while passing json %@",jsonError.localizedDescription)
                DispatchQueue.main.async {
                    activity.stopAnimating()
                }
            }
            
         }.resume()
        
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.rootArray?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        if let modelResult = self.rootArray.object(at: indexPath.row) as? Result{
            
            if let imageView = cell.viewWithTag(1001) as? UIImageView{
            
                if let casheImage = imageCache.object(forKey: modelResult.media[0].mediaMetadata[0].url) as? UIImage{
                   imageView.image = casheImage
                }else{                    
                    self.downloadImage(from: modelResult.media[0].mediaMetadata[0].url, imgViewRef: imageView)
                }
            }
            
    
            if let titleLbl = cell.viewWithTag(1002) as? UILabel{
                titleLbl.text = modelResult.title
            }
        }
        
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       self.performSegue(withIdentifier: "detailPage", sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailPage" {
            let destination:DetailViewController = segue.destination as! DetailViewController
            let result = self.rootArray.object(at: (self.tableView.indexPathForSelectedRow?.row)!) as! Result
            destination.resultDetails = result
            destination.parentController = self
            
        }
    }

    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    func downloadImage(from : String, contentMode mode : UIView.ContentMode = .scaleAspectFill, imgViewRef : UIImageView){
        
        guard let url = URL(string: from) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                imgViewRef.image = image
                self.imageCache.setValue(image, forKey: from)
            }
            }.resume()
        
    }
    
}

