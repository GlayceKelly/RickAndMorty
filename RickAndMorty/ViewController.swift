//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Glayce Kelly on 26/09/20.
//  Copyright © 2020 Glayce Kelly. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var characterURL: String = ""
    var results: [Results] = []
    var character: Character?
    var pages: Int = 0
    var loadingCharacters = false
    var currentPage: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func loadItems() {
        GeneralAPI.loadURLs { (info) in
            if let info = info {
                self.characterURL = info.characters
                self.loadCharacters()
                print("\(info.characters)")
            }
        }
    }
    
    func loadCharacters() {
        loadingCharacters = true
        
        GeneralAPI.loadCharacters(page: String(currentPage)) { (character) in
            if let character = character {
            
                self.character = character
                self.results += character.results
                self.pages = character.info.pages
                self.loadingCharacters = false
                
                self.tableView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = results[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let nextPageUrl: String = character?.info.next else { return }
        
        if indexPath.row == results.count - 10 && !loadingCharacters && results.count != pages {
            self.currentPage += 1
            loadCharacters()
        }
    }
}
