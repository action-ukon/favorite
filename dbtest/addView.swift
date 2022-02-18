
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
    
    var body: some View {
        VStack{
            HStack{
                Text("サイト名：")
                    .padding(1)
                TextField("サイト名", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(1)
            }
            HStack{
                Text("        URL：")
                    .padding(1)
                TextField("URL", text: $url)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(1)
            }
            Button("追加") {
                addItem()
                name = ""
                url = ""
            }
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
    }
}
