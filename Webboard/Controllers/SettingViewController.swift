//
//  SettingViewController.swift
//  Webboard
//
//  Created by Suriya on 28/10/2562 BE.
//  Copyright © 2562 Arthit Thongpan. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: Action
    @IBAction func logoutButtonTapped(_ sender: Any) {
        AuthorizationManager.shared.token = nil
        dismiss(animated: true, completion: nil)
    }
    
}
