//
//  EpisodiesCharacterViewController.swift
//  RickAndMorty
//
//  Created by Glayce Kelly on 28/10/20.
//  Copyright © 2020 Glayce Kelly. All rights reserved.
//

import UIKit

class EpisodiesCharacterViewController: UIViewController {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    private var viewModel: EpisodiesCharacterViewModel!
    private var episodiesURL: [String]?
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init(episodiesURLs: [String]?, episodiesViewModel: EpisodiesCharacterViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.episodiesURL = episodiesURLs
        self.viewModel = episodiesViewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //*************************************************
    // MARK: - LifeCycle
    //*************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if episodiesURL?.count ?? 0 > 1 {
            viewModel.loadMultipleEpisodies(tableView: nil)
        } else {
            viewModel.loadSingleEpisodie(tableView: nil)
        }
        
    }
    
    //*************************************************
    // MARK: - Actions
    //*************************************************


}

//*************************************************
// MARK: - Private Methods
//*************************************************

extension EpisodiesCharacterViewController {
    
}
