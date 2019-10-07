//
//  LandingViewController.swift
//  Webboard
//
//  Created by Arthit Thongpan on 6/10/2562 BE.
//  Copyright © 2562 Arthit Thongpan. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if AuthorizationManager.shared.token != nil {
            performSegue(withIdentifier: "Home", sender: nil)
        }else{
            performSegue(withIdentifier: "Authorization", sender: nil)
        }
    }

        // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         
        guard let identifer = segue.identifier else {return}
        
        switch identifer {
        case "Home":
            break
        case "Authorization":
            break
        default:
            break
        }
    }
    
}
