//
//  DonateViewController.swift
//  MyExpenseTrackerApp
//
//  Created by Никита Савенко on 14.05.2023.
//

import UIKit
import WebKit

class DonateViewController: UIViewController {

    @IBOutlet weak var donateWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: "https://savelife.in.ua/donate/#donate-army-card-monthly") {
            let request = URLRequest(url: url)
            DispatchQueue.main.async {
                self.donateWebView.load(request)
            }
        }
    }
}
