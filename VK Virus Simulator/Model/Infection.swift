//
//  Infection.swift
//  VK Virus Simulator
//
//  Created by Dmitry on 25.03.2024.
//

import Foundation
import UIKit

struct Edge {
    var from: Person
    var to: Person
}

class Person: Hashable {
    let id: Int
    var isInfected: Bool = false
    
    init(id: Int) {
        self.id = id
    }

    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

protocol InfectionDelegate: AnyObject {
    func updateCellColor(at indexPath: [IndexPath])
    
    func updateLabels()
    
}

final class Infection {
    weak var delegate: InfectionDelegate?

    private let groupCount: Int
    private let infectionFactor: Int
    let period: Double
    
    var people: [Person] = []
    var peopleGraph: [ Person: [Edge] ] = [:]


    private let columnCount: Int
    
    init(groupSize: Int, infectionFactor: Int, period: Double) {
        self.groupCount = groupSize
        self.infectionFactor = infectionFactor
        self.period = period
        self.columnCount = (groupSize + 19) / 20
    }
    
    var healthyCount = groupSize
    var infectedCount = 0
    var infectionStarted = false
    var infectedPeople: [Person] = []
    
    var time = 0
    
    
    func fillGraph() {
        for i in 0..<groupCount {
            let person = Person(id: i)
            people.append(person)
            peopleGraph[person] = []
        }
        for i in 0..<people.count {
            fillNeighbours(people[i])
        }
    }

    private func fillNeighbours(_ person: Person) {
        let id = person.id
        let row = id / 20
        let column = id % 20
        var neighbours: [(Int, Int)] = []
        
        let itemsPerRow = 20 
        for i in -1...1 {
            for j in -1...1 {
                if i == 0 && j == 0 {
                    continue
                }
                let newRow = row + i
                let newColumn = column + j
                
                if (newRow >= 0) && (newColumn >= 0) {
                    neighbours.append((newRow, newColumn))
                }
            }
        }
        
        neighbours.shuffle()
        
        for (newRow, newColumn) in neighbours {
            let neighbourId = newRow * itemsPerRow + newColumn
            if neighbourId < people.count {
                let neighbour = people[neighbourId]
                peopleGraph[person]?.append(Edge(from: person, to: neighbour))
            }
        }
    }
    
    func findGraphPosition(indexPath: IndexPath) -> Int {
        indexPath.row
    }

    func selectedCellInfect(indexPath: IndexPath) {
        let id = findGraphPosition(indexPath: indexPath)
        people[id].isInfected = true
        infectedPeople.append(people[id])

        infectedCount += 1
        healthyCount -= 1

        DispatchQueue.main.async {
            self.delegate?.updateCellColor(at: [indexPath])
            self.updateHealthyCount()
        }
        if !infectionStarted {
            print("started infection")
            startInfection()
            infectionStarted = true
        }
    }

    func infectNearby(_ person: Person) {
        var infectionsLeft = infectionFactor
        while infectionsLeft > 0 {
            let neighbours = peopleGraph[person]!.filter { !$0.to.isInfected }
            
            if neighbours.isEmpty {
                break
            }
            let randomNeighbour = neighbours.randomElement()!
            if randomNeighbour.to.isInfected {
                continue
            }
            randomNeighbour.to.isInfected = true
            infectedPeople.append(randomNeighbour.to)
            
            infectedCount += 1
            healthyCount -= 1
            infectionsLeft -= 1

            DispatchQueue.main.async {
                self.delegate?.updateCellColor(at: [IndexPath(row: randomNeighbour.to.id, section: 0)])
                self.updateHealthyCount()
            }
        }
    }
    
    func startInfection() {
        DispatchQueue.global().async { [weak self] in
            while true {
                guard let self = self else { return }
                Thread.sleep(forTimeInterval: self.period)
                for person in self.infectedPeople {
                    self.infectNearby(person)
                }
                time += Int(period)
                if self.infectedCount == self.groupCount {
                    print("ended infection")
                    break
                }
            }
        }
    }

    private func updateHealthyCount() {
        healthyCount = groupSize - infectedCount
        DispatchQueue.main.async {
            self.delegate?.updateLabels()
        }
    }

    func reset() {
        // reset all parameters
        healthyCount = groupSize
        infectedCount = 0

        for person in people {
            person.isInfected = false
        }
        infectedPeople.removeAll()
        infectionStarted = false

        DispatchQueue.main.async {
            self.delegate?.updateLabels()
        }
    }


}
