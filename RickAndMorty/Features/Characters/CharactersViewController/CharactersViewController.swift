//
//  CharactersViewController.swift
//  RickAndMorty
//
//  Created by Glayce Kelly on 29/09/20.
//  Copyright © 2020 Glayce Kelly. All rights reserved.
//

import UIKit

class CharactersViewController: UIViewController {
    
    //*************************************************
    // MARK: - IBOutlets
    //*************************************************
    
    @IBOutlet weak var charactersTableView: UITableView!
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    private var viewModel: CharactersViewModel!
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init(charactersViewModel: CharactersViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = charactersViewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //*************************************************
    // MARK: - LifeCycle
    //*************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.loadURLs()
        charactersTableView.delegate = self
        charactersTableView.dataSource = self
        
    }

    //*************************************************
    // MARK: - IBActions
    //*************************************************

    @IBAction func fetchCharacters(_ sender: Any) {
        viewModel.loadCharacters(tableView: charactersTableView)
    }
}

//*************************************************
// MARK: - Private Methods
//*************************************************

extension CharactersViewController {
    
}

//*************************************************
// MARK: - UITableViewDelegate, UITableViewDataSource
//*************************************************

extension CharactersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.results.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let result: Results = viewModel.results[indexPath.row]
        let viewModel: CharacterDetailViewModel = CharacterDetailViewModel(results: result)
        let viewController: UIViewController = CharacterDetailViewController(viewModel: viewModel)
        navigationController?.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("CharactersTableViewCell", owner: self, options: nil)?.first as! CharactersTableViewCell
        
        cell.prepareCell(with: viewModel.results[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == viewModel.results.count - 10 && !viewModel.loadingCharacters  {
            viewModel.fetchNextPage(tableView: tableView)
        }
    }
}
