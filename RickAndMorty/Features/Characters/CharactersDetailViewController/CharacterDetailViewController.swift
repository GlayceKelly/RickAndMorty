//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Glayce Kelly on 27/10/20.
//  Copyright © 2020 Glayce Kelly. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    //*************************************************
    // MARK: - IBOutlets
    //*************************************************
    
    @IBOutlet private weak var characterImageView: UIImageView!
    @IBOutlet private weak var characterNameLabel: UILabel!
    @IBOutlet private weak var speciesLabel: UILabel!
    @IBOutlet private weak var originLabel: UILabel!
    @IBOutlet private weak var episodiesButton: UIButton!
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    private var viewModel: CharacterDetailViewModel?
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init(viewModel: CharacterDetailViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //*************************************************
    // MARK: - LifeCycle
    //*************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel?.viewControllerTitle
        setupUI()
    }

    //*************************************************
    // MARK: - Actions
    //*************************************************
    
    
    @IBAction func episodiesAction(_ sender: UIButton) {
        viewModel?.navigateToEpisodiesScreen(viewController: self)
    }
    
}

//*************************************************
// MARK: - Private Methods
//*************************************************

extension CharacterDetailViewController {
    
    private func setupUI() {
        setupLabel()
        setupImageView()
    }
    
    private func setupLabel() {
        characterNameLabel.text = viewModel?.characterName
        speciesLabel.text = viewModel?.characterSpecies
        originLabel.text = viewModel?.characterOriginName
    }
    
    private func setupImageView() {
        let url = URL(string: viewModel?.characterImage ?? "")
        characterImageView.kf.setImage(with: url)
    }
}
