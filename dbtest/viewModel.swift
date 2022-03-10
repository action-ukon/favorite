//
//  File.swift
//  dbtest
//
//  Created by 坪田和樹 on 2022/02/17.
//

import Foundation

struct WebData: Identifiable{
    var id:UUID
    var name:String
    var url:String
    var order:Int64
}

var WebList = [
    WebData(id: UUID(), name: "Amazon", url: "https://www.amazon.co.jp", order: 0)
]

class User: ObservableObject {
    @Published var showingSheet:Bool = false
}
class Order: ObservableObject {
    @Published var order:Int64 = 0
}


