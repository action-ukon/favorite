
//
//  addView.swift
//  maruhiPJ
//
//  Created by 坪田和樹 on 2022/02/13.
//
import SwiftUI
import Foundation

struct addView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State var name:String = ""
    @State var url:String = ""
    @EnvironmentObject var showingSheet: User
    
    var body: some View {
        VStack{
            HStack{
                Text("サイト名：")
                    .padding()
                TextField("サイト名", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            HStack{
                Text("        URL：")
                    .padding()
                TextField("URL", text: $url)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            
            Button("追加") {
                if(name != "" && url != ""){
                    addItem()
                    name = "" as String
                    url = "" as String
                    showingSheet.showingSheet = false
                }
            }.frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
            
        }
    }
    func addItem() {
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


struct addView_Previews: PreviewProvider {
    static var previews: some View {
        addView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(User())
    }
}
