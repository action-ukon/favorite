//
//  ContentView.swift
//  dbtest
//
//  Created by 坪田和樹 on 2022/02/17.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>


    var body: some View {
        
        List {
            ForEach(items) { item in
                
                Text("Item at \(item.name!)")
         
            }
        }
        Text("Select an item")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
