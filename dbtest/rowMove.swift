////
////  rowMove.swift
////  favarite
////
////  Created by 坪田和樹 on 2022/03/05.
////
//
//import Foundation
//
//func rowReplace(from source: IndexSet, to destination: Int) {
//    //下から上に並べ替え時の挙動
//    if source.first! > destination {
//        items[source.first!].id = items[destination].id - 1
//        for i in destination...items.count - 1 {
//            items[i].id = items[i].id + 1
//        }
//    }
//
//    //上から下に並べ替え時の挙動
//    if source.first! < destination {
//        items[source.first!].id = items[destination - 1].id + 1
//        for i in 0...destination - 1 {
//            items[i].id = items[i].id - 1
//        }
//    }
//  saveData()
//}
//
//func saveData() {
//    try? self.viewContext.save()
//}
