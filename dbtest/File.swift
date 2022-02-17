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

class addList: ObservableObject {
    @Published var name = ""
    @Published var url = ""
}


//var WebList = [
//    WebData(name: "同人スマート", url: "http://ddd-smart.net/"),
//    WebData(name: "タレスト", url: "https://movie.eroterest.net"),
//    WebData(name: "Pornhub", url: "https://jp.pornhub.com/")
//]
var WebList = [
    WebData(name: "同人スマート", url: "http://ddd-smart.net/"),
    WebData(name: "タレスト", url: "https://movie.eroterest.net"),
    WebData(name: "Pornhub", url: "https://jp.pornhub.com/")
]
