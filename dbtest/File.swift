//
//  File.swift
//  dbtest
//
//  Created by 坪田和樹 on 2022/02/17.
//

import Foundation
struct WebData: Identifiable{
    var id = UUID()
    var name:String
    var url:String
}

var WebList = [
    WebData(name: "Amazon", url: "https://www.amazon.co.jp")
]

class User: ObservableObject {
    @Published var showingSheet:Bool = false
}
