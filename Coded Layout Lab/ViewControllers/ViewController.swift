//
//  ViewController.swift
//  Coded Layout Lab
//
//  Created by Jeroen Dunselman on 03/03/2020.
//  Copyright © 2020 Jeroen Dunselman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let data:DataService = DataService()
    var info:String = ""
    let activityView = UIActivityIndicatorView(style: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateResume()
        
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTap)
        )
        tapGesture.delegate = self as? UIGestureRecognizerDelegate
        view.addGestureRecognizer(tapGesture)
    }
    
    func updateResume() {
        showActivity()
        updateResumeData()
        guard self.data.storage != nil else {
            handleFail()
            return
        }
        
        showData()
    }
    
    func handleFail() {
        self.view.backgroundColor = .red
        self.activityView.isHidden = true
        let text = "Data not found"
        showMarquee(text)
        print(text)
    }
    
    func showActivity() {
        self.view.backgroundColor = .blue
        showActivityIndicator()
    }
    
    func showActivityIndicator() {
        
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        activityView.startAnimating()
    }
    
    func updateResumeData() {
        guard self.data.fetch() else {
            return
        }
    }
    
    @objc func handleTap() {
        let viewController:SchemaTVC = SchemaTVC()
        viewController.content = self.data.storage
        viewController.title = self.info
        self.navigationController?.pushViewController(viewController as UIViewController, animated: true)
    }
    
    func showData() {
        if let name = self.data.storage?.basics.name, let label = self.data.storage?.basics.label
        {
            self.info = "\(name), \(label)"
        }
        
        self.data.setImageViewToImageFile()
        let newView = UIImageView()
        newView.contentMode = .scaleAspectFill
        newView.image = self.data.profilePicture
        newView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newView)
        NSLayoutConstraint.activate(newView.constraintsForAnchoringTo(boundsOf: view))
        
        showMarquee(self.info)
    }
    
    func showMarquee(_ text: String) {
        let marquee = UIWebView()
        marquee.isOpaque = false
        marquee.backgroundColor = UIColor.clear
        marquee.loadHTMLString("<html><body style='background-color: transparent'><marquee style='color:white' scrolldelay='50' scrollamount='10' truespeed><font size='24'>\(self.info)</marquee></body></html>", baseURL: nil)
        view.addSubview(marquee)
        marquee.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: marquee, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: marquee, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: (view.frame.height / 2) * 0.6108).isActive = true
        NSLayoutConstraint(item: marquee, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: (view.frame.width - 64)).isActive = true
        NSLayoutConstraint(item: marquee, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 64).isActive = true
    }
    
}

extension UIView {
    
    /// Returns a collection of constraints to anchor the bounds of the current view to the given view.
    ///
    /// - Parameter view: The view to anchor to.
    /// - Returns: The layout constraints needed for this constraint.
    func constraintsForAnchoringTo(boundsOf view: UIView) -> [NSLayoutConstraint] {
        return [
            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
    }
}
