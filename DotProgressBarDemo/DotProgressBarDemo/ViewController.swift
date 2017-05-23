//
//  ViewController.swift
//  DotProgressBarDemo
//
//  Created by Rob Norback on 5/23/17.
//  Copyright © 2017 Norback Solutions, LLC. All rights reserved.
//

import UIKit
import DotProgressBar

class ViewController: UIViewController {
    
    var hdotBar:DotProgressBar!
    var vdotBar:DotProgressBar!
    var textField:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let prev = UIButton()
        prev.translatesAutoresizingMaskIntoConstraints = false
        prev.addTarget(self, action: #selector(ViewController.prevPushed), for: .touchUpInside)
        prev.setTitle("< Prev", for: .normal)
        prev.setTitleColor(.black, for: .normal)
        view.addSubview(prev)
        
        prev.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -70).isActive = true
        prev.heightAnchor.constraint(equalToConstant: 10).isActive = true
        prev.widthAnchor.constraint(equalToConstant: 100).isActive = true
        prev.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        
        let next = UIButton()
        next.translatesAutoresizingMaskIntoConstraints = false
        next.addTarget(self, action: #selector(ViewController.nextPushed), for: .touchUpInside)
        next.setTitle("Next >", for: .normal)
        next.setTitleColor(.black, for: .normal)
        view.addSubview(next)
        
        next.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 70).isActive = true
        next.heightAnchor.constraint(equalToConstant: 10).isActive = true
        next.widthAnchor.constraint(equalToConstant: 100).isActive = true
        next.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        
        let update = UIButton()
        update.translatesAutoresizingMaskIntoConstraints = false
        update.addTarget(self, action: #selector(ViewController.updatePushed), for: .touchUpInside)
        update.setTitle("Update", for: .normal)
        update.setTitleColor(.black, for: .normal)
        view.addSubview(update)
        
        update.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        update.heightAnchor.constraint(equalToConstant: 10).isActive = true
        update.widthAnchor.constraint(equalToConstant: 100).isActive = true
        update.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        
        textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        view.addSubview(textField)
        
        textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.widthAnchor.constraint(equalToConstant: 40).isActive = true
        textField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120).isActive = true
        
        hdotBar = DotProgressBar(numberOfDots: 4, orientation: .horizontal, startingDot: 0)
        hdotBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hdotBar)
        
        hdotBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        hdotBar.heightAnchor.constraint(equalToConstant: 20).isActive = true
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
    
    func updatePushed() {
        hdotBar.updateProgress(toDot: Int(textField.text!)!)
        vdotBar.updateProgress(toDot: Int(textField.text!)!)
        textField.text = nil
    }
    
    func prevPushed() {
        hdotBar.prev()
        vdotBar.prev()
    }
    
    func nextPushed() {
        hdotBar.next()
        vdotBar.next()
    }
}

