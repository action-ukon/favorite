//
//  ContentView.swift
//  dbtest
//
//  Created by 坪田和樹 on 2022/02/17.
//

import SwiftUI

struct ContentView: View {
     @Environment(\.managedObjectContext) private var viewContext
     
     @FetchRequest(
          sortDescriptors: [NSSortDescriptor(keyPath: \Item.order, ascending: true)],
          animation: .default)
     
     private var items: FetchedResults<Item>
     @EnvironmentObject var showingSheet: User
     @EnvironmentObject var order: Order
     
     //issue IDを一意にする
     var body: some View {
          VStack{
               NavigationView {
                    List {
                         ForEach(items) { item in
                              let url = URL(string: item.url ?? "")!
                              let link = Link(item.name ?? "", destination: url)
                              let errLink = Text(item.name ?? "").foregroundColor(.gray).strikethrough() + Text("　※リンクが有効ではありません")
                              // 三項演算子BaseNode
                              if(UIApplication.shared.canOpenURL(url)){
                                   link
                              }else{
                                   errLink
                              }
                         }.onDelete(perform: deleteItems) .onMove(perform: rowReplace)
                         Button("+") {
                              self.showingSheet.showingSheet.toggle()
                         }.sheet(isPresented: $showingSheet.showingSheet) {
                              addView()
                         }
                    }.toolbar {
                         ToolbarItem(placement: .navigationBarTrailing) {
                              EditButton().font(.system(size: 20))
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

     func rowReplace(from source: IndexSet, to destination: Int) {
         //下から上に並べ替え時の挙動
         if source.first! > destination {
             items[source.first!].order = items[destination].order - 1
             for i in destination...items.count - 1 {
                 items[i].order = items[i].order + 1
             }
         }

         //上から下に並べ替え時の挙動
         if source.first! < destination {
             items[source.first!].order = items[destination - 1].order + 1
             for i in 0...destination - 1 {
                 items[i].order = items[i].order - 1
             }
         }
       saveData()
     }

     func saveData() {
         try? self.viewContext.save()
     }
}

struct ContentView_Previews: PreviewProvider {
     static var previews: some View {
          ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
               .environmentObject(User())
               .environmentObject(Order())
     }
}
