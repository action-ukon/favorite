//
//  File.swift
//  dbtest
//
//  Created by 坪田和樹 on 2022/02/17.
//

import Foundation
struct WebData: Identifiable{
//    var timestamp = Date()
    var id:Int64
    var name:String
    var url:String
}

var WebList = [
    WebData(id:0, name: "Amazon", url: "https://www.amazon.co.jp")
]

class User: ObservableObject {
    @Published var showingSheet:Bool = false
}
class Id: ObservableObject {
    @Published var id:Int64 = 0
}
