//
//  DetailsView.swift
//  SnowSeeker
//
//  Created by Alexander Bonney on 7/14/21.
//

import SwiftUI

struct DetailsView: View {
    let resort: Resort
    @State private var selectedFacility: Facility?
    @EnvironmentObject var viewModel: ResortsViewModel
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image(resort.id).resizable().scaledToFit()
                    HStack {
                        Text("Photo by \(resort.imageCredit)").foregroundColor(.secondary).font(.caption).padding(.horizontal, 10)
                        Spacer()
                    }
                    ResortDetailsView(resort: resort, geo: geo)
                    Text(resort.description).padding()
                    Text("Facilities").font(.headline)
                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                                facility.icon
                                    .font(.title)
                                    .onTapGesture {
                                        self.selectedFacility = facility
                                    }
                            }
                    }.padding(.vertical)
                }
            }
        }.alert(item: $selectedFacility) { facility in
            facility.alert
        }
        .navigationBarTitle(resort.name, displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            if self.viewModel.contains(self.resort) {
                self.viewModel.remove(self.resort)
            } else {
                self.viewModel.add(self.resort)
            }
        }, label: {
            Group {
                viewModel.contains(resort)
                    ? Image(systemName: "heart.fill")
                    : Image(systemName: "heart")
            }.foregroundColor(.red)
        }))
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailsView(resort: Resort.example)
        }
    }
}


struct ResortDetailsView: View {
    @Environment(\.horizontalSizeClass) var horizontalsizeClass
    let resort: Resort
    
    var size: String {
        switch resort.size {
        case 1:
            return "Small"
        case 2:
            return "Average"
        default:
            return "Large"
        }
    }
    
    var price: String {
        String(repeating: "$", count: resort.price)
    }
    
    var geo: GeometryProxy
    
    var body: some View {
        if horizontalsizeClass == .compact {
            if geo.size.height > geo.size.width {
                HStack {
                    Spacer()
                    VStack {
                        Text("Size: \(size)")
                        Text("Price: \(price)")
                    }
                    VStack {
                        Text("Elevation: \(resort.elevation)m")
                        Text("Snow: \(resort.snowDepth)cm")
                    }
                    Spacer()
                }
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.top)
            } else {
                HStack {
                    Spacer()
                    Text("Size: \(size)")
                    Spacer()
                    Text("Price: \(price)")
                    Spacer()
                    Text("Elevation: \(resort.elevation)m")
                    Spacer()
                    Text("Snow: \(resort.snowDepth)cm")
                    Spacer()
                }
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.top)
            }
        } else {
            HStack {
                Spacer()
                Text("Size: \(size)")
                Spacer()
                Text("Price: \(price)")
                Spacer()
                Text("Elevation: \(resort.elevation)m")
                Spacer()
                Text("Snow: \(resort.snowDepth)cm")
                Spacer()
            }
            .font(.headline)
            .foregroundColor(.secondary)
            .padding(.top)
        }
        
    }
}
