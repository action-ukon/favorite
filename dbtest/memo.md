#  <#Title#>

private func move(from source: IndexSet, to destination: Int) {
        //下から上に並べ替え時の挙動
        if source.first! > destination {
            todoList[source.first!].data = todoList[destination].data - 1
            for i in destination...todoList.count - 1 {
                todoList[i].data = todoList[i].data + 1
            }
        }

        //上から下に並べ替え時の挙動
        if source.first! < destination {
            todoList[source.first!].data = todoList[destination - 1].data + 1
            for i in 0...destination - 1 {
                todoList[i].data = todoList[i].data - 1
            }
        }
      saveData()
    }

    private func saveData() {
        try? self.viewContext.save()
    }
