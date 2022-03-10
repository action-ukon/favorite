
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
    @EnvironmentObject var order: Order
    
    var body: some View {
        VStack{
            HStack{
                VStack{
                Text("サイト名")
                        .frame(width: 350, height: 30, alignment: .leading)
                TextField("サイト名", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                }
            }
            HStack{
                VStack{
                Text("URL")
                        .frame(width: 350, height: 30, alignment: .leading)
                TextField("URL", text: $url)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                    .onChange(of: url, perform: urlFilter)
                }
            }
            
            Button("追加") {
                if(name != "" && url != ""){
                    order.order = order.order + 1
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
            newItem.order = order.order
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    func urlFilter(value: String) {
        //禁止文字：%
            let validedCodes = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-_.!/:=&+?#"
            let sets = CharacterSet(charactersIn: validedCodes)
            url = String(value.unicodeScalars.filter(sets.contains).map(Character.init))
    }
}


struct addView_Previews: PreviewProvider {
    static var previews: some View {
        addView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(User())
            .environmentObject(Order())
    }
}
