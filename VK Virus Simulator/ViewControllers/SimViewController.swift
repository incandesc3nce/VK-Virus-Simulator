//
//  SimViewController.swift
//  VK Virus Simulator
//
//  Created by Dmitry on 24.03.2024.
//

import Foundation
import UIKit

//MARK: to-do list
// all done :)


class SimViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, InfectionDelegate {
    

    let infection = Infection(groupSize: groupSize, infectionFactor: infectionFactor, period: T)
    
    
    var peopleCollection: UICollectionView!
    
    var amountOfHealthy = groupSize
    var amountOfInfected = 0
    
    var healthyLabel: UILabel!
    var infectedLabel: UILabel!
    
    var collectionViewLayout: UICollectionViewFlowLayout!

    var collectionViewScrollView: UIScrollView!

    override func loadView() {
        view = UIView()
        view.backgroundColor = convertColorFromRGB(r: 144, g: 56, b: 56, alpha: 1)
        
        
        collectionViewLayout = UICollectionViewFlowLayout()
        
        peopleCollection = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout)
        peopleCollection.translatesAutoresizingMaskIntoConstraints = false
        peopleCollection.backgroundColor = convertColorFromRGB(r: 105, g: 43, b: 43, alpha: 1)
        
        peopleCollection.layer.borderWidth = 0.5
        peopleCollection.layer.borderColor = convertColorFromRGB(r: 248, g: 138, b: 138, alpha: 1).cgColor
        

        collectionViewScrollView = UIScrollView()
        collectionViewScrollView.addSubview(peopleCollection)
        collectionViewScrollView.minimumZoomScale = 1.0
        collectionViewScrollView.maximumZoomScale = 3.0
        
        collectionViewScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionViewScrollView.delegate = self
        
        view.addSubview(collectionViewScrollView)
        
        

        NSLayoutConstraint.activate([
            collectionViewScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionViewScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionViewScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionViewScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        
        NSLayoutConstraint.activate([
            peopleCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            peopleCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            peopleCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            peopleCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -65)
        ])

        healthyLabel = UILabel()
        healthyLabel.text = "Здоровых: \(amountOfHealthy)"
        healthyLabel.textColor = .white
        healthyLabel.font = UIFont.boldSystemFont(ofSize: 16)
        healthyLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(healthyLabel)

        infectedLabel = UILabel()
        infectedLabel.text = "Зараженных: \(amountOfInfected)"
        infectedLabel.textColor = .white
        infectedLabel.font = UIFont.boldSystemFont(ofSize: 16)
        infectedLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(infectedLabel)

        NSLayoutConstraint.activate([
            healthyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            healthyLabel.bottomAnchor.constraint(equalTo: peopleCollection.bottomAnchor, constant: 30),
            healthyLabel.heightAnchor.constraint(equalToConstant: 20),
            
            infectedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infectedLabel.topAnchor.constraint(equalTo: healthyLabel.bottomAnchor, constant: 5),
            infectedLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return peopleCollection
    }

    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        let zoomedSize = CGSize(width: peopleCollection.frame.size.width * scale,
                                height: peopleCollection.frame.size.height * scale)
        peopleCollection.frame.size = zoomedSize
        scrollView.contentSize = zoomedSize
    }
    
    @objc func handlePinchGesture(_ gesture: UIPinchGestureRecognizer) {
        if gesture.state == .began || gesture.state == .changed {
            let currentScale = self.view.frame.size.width / self.view.bounds.size.width
            var newScale = currentScale*gesture.scale

            if newScale < 1.0 {
                newScale = 1.0
            }
            if newScale > 5.0 {
                newScale = 5.0
            }

            let transform = CGAffineTransform(scaleX: newScale, y: newScale)
            self.view.transform = transform
            gesture.scale = 1.0
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        peopleCollection.dataSource = self
        peopleCollection.delegate = self
        peopleCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "peopleCell")
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
        peopleCollection.addGestureRecognizer(pinchGesture)
        
        infection.delegate = self
    }

    func updateCellColor(at indexPath: [IndexPath]) {
        peopleCollection.cellForItem(at: indexPath[0])?.backgroundColor = .red
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
    }

}
