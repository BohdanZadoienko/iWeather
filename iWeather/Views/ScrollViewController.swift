//
//  ScrollViewController.swift
//  iWeather
//
//  Created by Bohdan Zadoienko on 17.07.23.
//

import UIKit

class ScrollViewController: UIViewController {

    var scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createScrollView()
    }
    
    func createScrollView(){
        

        view.addSubview(scrollView)
    }
}
