//
//  CollectionViewSetup.swift
//  VK Virus Simulator
//
//  Created by Dmitry on 25.03.2024.
//

import Foundation
import UIKit

extension SimViewController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        infection.fillGraph()
        return groupSize
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "peopleCell", for: indexPath)

        let person = infection.people[indexPath.row]
        cell.backgroundColor = person.isInfected ? .red : .green

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        if cell?.backgroundColor == .green {
            DispatchQueue.main.async {
                cell?.backgroundColor = .red
            }
            DispatchQueue.global(qos: .userInteractive).async {
                self.infection.selectedCellInfect(indexPath: indexPath)
            }
            
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 20

        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            self.collectionViewLayout = flowLayout

            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

            return CGSize(width: size, height: size)
        }
        return CGSize(width: 0, height: 0)
    }
    
    
}
