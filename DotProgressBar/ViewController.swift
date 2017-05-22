//
//  ViewController.swift
//  PageProgressBar
//
//  Created by Rob Norback on 5/18/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var hdotBar:DotProgressBar!
    var vdotBar:DotProgressBar!
    var textField:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(ViewController.buttonPushed), for: .touchUpInside)
        button.setTitle("Update", for: .normal)
        button.setTitleColor(.black, for: .normal)
        view.addSubview(button)
        
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 10).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        
        textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        view.addSubview(textField)
        
        textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.widthAnchor.constraint(equalToConstant: 40).isActive = true
        textField.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -20).isActive = true
        
        hdotBar = DotProgressBar(numberOfDots: 4, orientation: .horizontal)
        hdotBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hdotBar)
        
        hdotBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        hdotBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        hdotBar.widthAnchor.constraint(equalToConstant: 200).isActive = true
        hdotBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        
        vdotBar = DotProgressBar(numberOfDots: 4, orientation: .vertical)
        vdotBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vdotBar)
        
        vdotBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        vdotBar.heightAnchor.constraint(equalToConstant: 200).isActive = true
        vdotBar.widthAnchor.constraint(equalToConstant: 20).isActive = true
        vdotBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
    }
    
    func buttonPushed() {
        print(textField.text!)
        hdotBar.updateProgress(toDot: Int(textField.text!)!)
        vdotBar.updateProgress(toDot: Int(textField.text!)!)
        textField.text = nil
    }
    
    func injected() {
        viewDidLoad()
    }
}

