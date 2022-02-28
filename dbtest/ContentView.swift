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
     @EnvironmentObject var id: Id
     
     var body: some View {
          VStack{
               NavigationView {
                    List {
                         ForEach(items) { item in
                              let url = URL(string: item.url ?? "")!
                              if(UIApplication.shared.canOpenURL(url)){
                                   Link(item.name ?? "", destination: url)
                              }else{
                                   Text(item.name ?? "")
                                        .foregroundColor(.gray)
                                        .strikethrough()
                                   + Text("　※リンクが有効ではありません")
                              }
                         }.onDelete(perform: deleteItems)
//                              .onMove(perform: rowReplace)
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
     //TODOバグ 未来に期待
//     func rowReplace(_ from: IndexSet, _ to: Int) {
//          WebList.move(fromOffsets: from, toOffset: to)
//     }
     
}

struct ContentView_Previews: PreviewProvider {
     static var previews: some View {
          ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
               .environmentObject(User())
               .environmentObject(Id())
     }
}
