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
     @EnvironmentObject var showingSheet: User
    
    var body: some View {
        VStack{
            NavigationView {
                List {
                    ForEach(items) { item in
                        HStack{
                            Link(item.name ?? "nil", destination: URL(string: item.url ?? "nil")!)
                        }
                    }.onDelete(perform: deleteItems)
                }.toolbar {
                    /// ナビゲーションバーの右に+ボタン配置
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("+") {
                            self.showingSheet.showingSheet.toggle()
                        }
                        .sheet(isPresented: $showingSheet.showingSheet) {
                            addView()
                        }
                        
                    }
                }.navigationTitle("お気に入り")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
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
              .environmentObject(User())
    }
}
