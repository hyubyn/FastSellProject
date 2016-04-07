//
//  StartViewController.swift
//  FastSell
//
//  Created by HYUBYN on 4/6/16.
//  Copyright © 2016 hyubyn. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        AppUtils.addRadius(addButton)
        AppUtils.addRadius(searchButton)
    }

}
