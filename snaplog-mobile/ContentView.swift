//
//  ContentView.swift
//  snaplog-mobile
//
//  Created by Samuel Wong on 6/4/2023.
//

import SwiftUI

struct Film: Identifiable {
    let id = UUID()
    let name: String
    let purchaseLocation: String
    let purchasePrice: Double
    let date: Date
}

struct ContentView: View {
    @State private var films = [
        Film(name: "Film 1", purchaseLocation: "Location 1", purchasePrice: 12.99, date: Date()),
        Film(name: "Film 2", purchaseLocation: "Location 2", purchasePrice: 11.99, date: Date()),
        Film(name: "Film 3", purchaseLocation: "Location 3", purchasePrice: 8.99, date: Date())
    ]
    @State private var showingAddFilmModal = false
    
    var body: some View {
        NavigationView {
            List(films) { film in
                VStack(alignment: .leading) {
                    Text(film.name)
                    Text(film.purchaseLocation)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("Date: \(formattedDate(date: film.date))")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .navigationBarTitle("Snaplog")
            .navigationBarItems(
                leading: Button(action: {
                    // Action to show settings view
                }) {
                    Image(systemName: "gear")
                },
                trailing: Button(action: {
                    showingAddFilmModal = true
                }) {
                    Image(systemName: "plus")
                }
            )
        }
        .sheet(isPresented: $showingAddFilmModal) {
            // Modal to add film object data
            AddFilmView(films: $films, showingModal: $showingAddFilmModal)
        }
        
    }
    
    // Helper function to format date
       private func formattedDate(date: Date) -> String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "MMM d, yyyy"
           return dateFormatter.string(from: date)
       }
}

struct AddFilmView: View {
    @Binding var films: [Film]
    @Binding var showingModal: Bool
    @State private var name = ""
    @State private var purchaseLocation = ""
    @State private var date = Date()
    @State private var purchasePrice = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Film Details")) {
                    TextField("Name", text: $name)
                    TextField("Purchase Location", text: $purchaseLocation)
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                    TextField("Purchase Price", text: $purchasePrice)
                        .keyboardType(.decimalPad)
                }

                Section {
                    Button("Save", action: saveFilm)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationBarTitle("Add Film")
            .navigationBarItems(leading: Button(action: {
                showingModal = false
            }, label: {
                Text("Cancel")
            }), trailing: Button(action: {
                saveFilm()
            }, label: {
                Text("Save") // Updated to "Save"
            }))
        }
    }

    private func saveFilm() {
        guard let purchasePrice = Double(purchasePrice) else {
            return
        }

        let film = Film(name: name, purchaseLocation: purchaseLocation, purchasePrice: purchasePrice, date: date)
        films.append(film)
        showingModal = false
    }
}

struct Previews_ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
