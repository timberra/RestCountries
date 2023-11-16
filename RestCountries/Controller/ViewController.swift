//
//  ViewController.swift
//  RestCountries
//
//  Created by liga.griezne on 16/11/2023.
//

import UIKit

class ViewController: UITableViewController {
    
    private let cellID = "cell"
    private let countryAllUrl = "https://restcountries.com/v3.1/all"
    private var countries: [Country] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupView()
        
        NetworkManager.fetchData(url: countryAllUrl){
            countries in
            self.countries = countries
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        tableView.addGestureRecognizer(longPressGesture)
    }
    
    @objc private func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let touchPoint = gestureRecognizer.location(in: tableView)
            
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                showCountryInfoAlert(for: countries[indexPath.row])
            }
        }
    }
    
    private func showCountryInfoAlert(for country: Country) {
        let alert = UIAlertController(
            title: country.name.common,
            message: "Capital: \(country.capital?.joined() ?? "N/A")\nRegion: \(country.region ?? "N/A")\nTimezone: \(country.timezones?.joined() ?? "N/A")",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }

    
    
    private func setupView(){
        view.backgroundColor = .secondarySystemBackground
        tableView.register(UITableViewCell.self,forCellReuseIdentifier: cellID)
        setupNavigationBar()
        
    }
    
    private func setupNavigationBar(){
        
        self.title = "Countries"
        let titleImage = UIImage(systemName: "mappin.and.ellipse")
        let imageView = UIImageView(image:titleImage)
        self.navigationItem.titleView = imageView
        
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor:UIColor.label]
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.label]
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = .label
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID, for:indexPath  as IndexPath)
        cell = UITableViewCell(style:UITableViewCell.CellStyle.subtitle,reuseIdentifier: cellID)
        
        let country = self.countries[indexPath.row]
        cell.textLabel?.text = country.name.common
        cell.detailTextLabel?.text = country.name.official
        return cell
    }
    
}
    
    

