//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Alexander Bonney on 7/15/21.
//

import SwiftUI

class ResortsViewModel: ObservableObject {
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let saveKey = "Favorites"
    let defaultResortsList: [Resort] = Bundle.main.decode("resorts.json")
    @Published var resortsMailList: [Resort] = []
    @Published var filterState: FilteringResorts = FilteringResorts(byCountry: .all, bySize: .all, byPrice: .all)
    @Published var sortingState: Sorting = .name
    @Published var isFiltered: Bool = false
    
    private var resorts: Set<String>
    
    init() {
        self.resortsMailList = self.defaultResortsList.sorted {
            $0.name < $1.name
        }
        //load data
        var decodedData = Set<String>()
        let filename = Self.documentsDirectory.appendingPathComponent(Self.saveKey)
        let decoder = JSONDecoder()
        do {
            let resorts = try Data(contentsOf: filename)
            decodedData = try decoder.decode(Set<String>.self, from: resorts)
        } catch {
            print("Unable to load saved data.")
        }
        self.resorts = decodedData
    }
    
    // returns true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    // adds the resort to our set, updates all views, and saves the change
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    // removes the resort from our set, updates all views, and saves the change
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        // write out our data
        let encoder = JSONEncoder()
        do {
            let filename = Self.documentsDirectory.appendingPathComponent(Self.saveKey)
            let encoded = try encoder.encode(resorts)
            try encoded.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func sort(by what: Sorting) {
        DispatchQueue.main.async {
            withAnimation() {
                switch what {
                case .name:
                    self.sortingState = .name
                    self.resortsMailList.sort {
                        $0.name < $1.name
                    }
                case .country:
                    self.sortingState = .country
                    self.resortsMailList.sort {
                        $0.country < $1.country
                    }
                }
            }
        }
    }
    func filterResorts(by filters: FilteringResorts) {
        DispatchQueue.main.async {
            
            var startArray = self.resortsMailList
            print(self.filterState.byCountry)
            switch filters.byCountry {
            case .all:
                switch self.sortingState {
                case .name:
                    startArray = self.defaultResortsList.sorted {
                        $0.name < $1.name
                    }
                case .country:
                    startArray = self.defaultResortsList.sorted {
                        $0.country < $1.country
                    }
                }
            case .austria:
                startArray = self.defaultResortsList.sorted {
                    $0.name < $1.name
                }
                startArray.removeAll(where: {$0.country != "Austria"})
            case .france:
                startArray = self.defaultResortsList.sorted {
                    $0.name < $1.name
                }
                startArray.removeAll(where: {$0.country != "France"})
            case .italy:
                startArray = self.defaultResortsList.sorted {
                    $0.name < $1.name
                }
                startArray.removeAll(where: {$0.country != "Italy"})
            case .us:
                startArray = self.defaultResortsList.sorted {
                    $0.name < $1.name
                }
                startArray.removeAll(where: {$0.country != "United States"})
            case .canada:
                startArray = self.defaultResortsList.sorted {
                    $0.name < $1.name
                }
                startArray.removeAll(where: {$0.country != "Canada"})
            }
            
            switch filters.bySize {
            case .one:
                startArray.removeAll(where: {$0.size != 1})
            case .two:
                startArray.removeAll(where: {$0.size != 2})
            case .three:
                startArray.removeAll(where: {$0.size != 3})
            default:
                break
            }
            
            switch filters.byPrice {
            case .one:
                startArray.removeAll(where: {$0.price != 1})
            case .two:
                startArray.removeAll(where: {$0.price != 2})
            case .three:
                startArray.removeAll(where: {$0.price != 3})
            default:
                break
            }
            
            self.resortsMailList = startArray
        }
    }
}

enum Sorting {
    case name
    case country
}

struct FilteringResorts {
    var byCountry: CountryFilter = .all
    var bySize: SizeAndPriceFilter = .all
    var byPrice: SizeAndPriceFilter = .all
}

enum CountryFilter {
    case all
    case austria
    case france
    case italy
    case us
    case canada
}

enum SizeAndPriceFilter {
    case all
    case one
    case two
    case three
}
