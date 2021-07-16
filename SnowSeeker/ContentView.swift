//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Alexander Bonney on 7/13/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ResortsViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.resortsMailList) { resort in
                NavigationLink(
                    destination: DetailsView(resort: resort),
                    label: {
                        Image(resort.country).resizable().scaledToFill().frame(width: 40, height: 25).clipShape(RoundedRectangle(cornerRadius: 5)).overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
                        VStack(alignment: .leading) {
                            Text(resort.name)
                            Text("\(resort.runs) runs").foregroundColor(.secondary)
                        }
                        if self.viewModel.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibility(label: Text("This is a favorite resort"))
                                .foregroundColor(.red)
                        }
                    })
            }
            .navigationTitle("Finding snow")
            .navigationBarItems(leading: Menu(content: {
                Menu {
                    Button(action:  {
                        DispatchQueue.main.async {
                            viewModel.filterState.byCountry = .all
                            viewModel.filterResorts(by: viewModel.filterState)
                        }
                    }, label: {
                        if viewModel.filterState.byCountry == .all {
                            Image(systemName: "checkmark")
                        }
                        Text("All")
                    })
                    Button {
                        DispatchQueue.main.async {
                            viewModel.filterState.byCountry = .austria
                            viewModel.filterResorts(by: viewModel.filterState)
                        }
                    } label: {
                        if viewModel.filterState.byCountry == .austria {
                            Image(systemName: "checkmark")
                        }
                        Text("Austria")
                    }
                    Button(action: {
                        DispatchQueue.main.async {
                            viewModel.filterState.byCountry = .france
                            viewModel.filterResorts(by: viewModel.filterState)
                        }
                    }, label: {
                        if viewModel.filterState.byCountry == .france {
                            Image(systemName: "checkmark")
                        }
                        Text("France")
                    })
                    Button(action: {
                        DispatchQueue.main.async {
                            viewModel.filterState.byCountry = .italy
                            viewModel.filterResorts(by: viewModel.filterState)
                        }
                    }, label: {
                        if viewModel.filterState.byCountry == .italy {
                            Image(systemName: "checkmark")
                        }
                        Text("Italy")
                    })
                    Button(action: {
                        DispatchQueue.main.async {
                            viewModel.filterState.byCountry = .us
                            viewModel.filterResorts(by: viewModel.filterState)
                        }
                    }, label: {
                        if viewModel.filterState.byCountry == .us {
                            Image(systemName: "checkmark")
                        }
                        Text("The United States")
                    })
                    Button(action: {
                        DispatchQueue.main.async {
                            viewModel.filterState.byCountry = .canada
                            viewModel.filterResorts(by: viewModel.filterState)
                        }
                    }, label: {
                        if viewModel.filterState.byCountry == .canada {
                            Image(systemName: "checkmark")
                        }
                        Text("Canada")
                    })
                } label: {
                    Text("Country")
                }
                
                Menu {
                    Button(action:  {
                        DispatchQueue.main.async {
                            viewModel.filterState.bySize = .all
                            viewModel.filterResorts(by: viewModel.filterState)
                        }
                    }, label: {
                        if viewModel.filterState.bySize == .all {
                            Image(systemName: "checkmark")
                        }
                        Text("All")
                    })
                    Button(action:  {
                        DispatchQueue.main.async {
                            viewModel.filterState.bySize = .one
                            viewModel.filterResorts(by: viewModel.filterState)
                        }
                    }, label: {
                        if viewModel.filterState.bySize == .one {
                            Image(systemName: "checkmark")
                        }
                        Text("Small")
                    })
                    Button(action:  {
                        DispatchQueue.main.async {
                            viewModel.filterState.bySize = .two
                            viewModel.filterResorts(by: viewModel.filterState)
                        }
                    }, label: {
                        if viewModel.filterState.bySize == .two {
                            Image(systemName: "checkmark")
                        }
                        Text("Average")
                    })
                    Button(action:  {
                        DispatchQueue.main.async {
                            viewModel.filterState.bySize = .three
                            viewModel.filterResorts(by: viewModel.filterState)
                        }
                    }, label: {
                        if viewModel.filterState.bySize == .three {
                            Image(systemName: "checkmark")
                        }
                        Text("Large")
                    })
                } label: {
                    Text("Size")
                }

                Menu {
                    Button(action:  {
                        DispatchQueue.main.async {
                            viewModel.filterState.byPrice = .all
                            viewModel.filterResorts(by: viewModel.filterState)
                        }
                    }, label: {
                        if viewModel.filterState.byPrice == .all {
                            Image(systemName: "checkmark")
                        }
                        Text("All")
                    })
                    Button(action:  {
                        DispatchQueue.main.async {
                            viewModel.filterState.byPrice = .one
                            viewModel.filterResorts(by: viewModel.filterState)
                        }
                    }, label: {
                        if viewModel.filterState.byPrice == .one {
                            Image(systemName: "checkmark")
                        }
                        Text("$")
                    })
                    Button(action:  {
                        DispatchQueue.main.async {
                            viewModel.filterState.byPrice = .two
                            viewModel.filterResorts(by: viewModel.filterState)
                        }
                    }, label: {
                        if viewModel.filterState.byPrice == .two {
                            Image(systemName: "checkmark")
                        }
                        Text("$$")
                    })
                    Button(action:  {
                        DispatchQueue.main.async {
                            viewModel.filterState.byPrice = .three
                            viewModel.filterResorts(by: viewModel.filterState)
                        }
                    }, label: {
                        if viewModel.filterState.byPrice == .three {
                            Image(systemName: "checkmark")
                        }
                        Text("$$$")
                    })
                } label: {
                    Text("Price")
                }
            }, label: {
                Text("Filter")
            }) , trailing:
                    Menu(content: {
                        Button(action: {
                            print("sorted by name")
                            viewModel.sort(by: .name)
                        }, label: {
                            if viewModel.sortingState == .name {
                                Image(systemName: "checkmark")
                            }
                            Text("Name")
                        })
                        Button(action: {
                            print("sorted by country")
                            viewModel.sort(by: .country)
                        }, label: {
                            if viewModel.sortingState == .country {
                                Image(systemName: "checkmark")
                            }
                            Text("Coutry")
                        })
                    }, label: {
                        Text("Sort By")
                    })
            )
            
            WelcomeView()
        }.environmentObject(viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
