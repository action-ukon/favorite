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
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.id, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var name = ""
    var url = ""
    
    var body: some View {
        VStack{
            NavigationView {
                List {
                    ForEach(items) { item in
                        Text("\(item.name!)  \(item.url!)")
                    }
                }.toolbar {
                    /// ナビゲーションバーの右に+ボタン配置
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: addItem) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
            }
        }
    }
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.id = UUID()
            newItem.name = name
            newItem.url = url
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
