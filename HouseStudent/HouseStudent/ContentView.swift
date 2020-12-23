
//
//  ContentView.swift
//  CoreDataExample
//
//  Created by ranaurogiuliano on 22/12/2020.
//

import SwiftUI



struct ContentView: View {
    @Environment(\.managedObjectContext)public var viewContext     //salvo in viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Task.date, ascending: true)]) //posso effettuare il sorting qui
    private var tasks: FetchedResults<Task>
    
    @State var showAddTask = false
    
    var body: some View {
        NavigationView{
            //List{
                ForEach(tasks){ task in
                    /*Text(task.title ?? "Error")
                        .onTapGesture(count: 1, perform: {
                            updateTask(task)
                        })*/
                    TaskView(title: task.title ?? "Error", date: task.date ?? Date())
                        .padding(5)
                }.onDelete(perform: deleteTask)
            //}
            .navigationBarTitle("Todo List")
            .navigationBarItems(trailing: Button("Add"){
                //addTask()
                showAddTask.toggle()
        })
            .sheet(isPresented: $showAddTask){
                AddTaskView()
            }
    }
}
    private func updateTask(_ task: FetchedResults<Task>.Element){
        withAnimation{
            task.title = "new Title "
            saveContext()
            
        }
    }
    
    private func deleteTask(offsets: IndexSet){
        withAnimation{
            //il $0 rappresenta tutti gli index nel set
            offsets.map{ tasks[$0]}.forEach(viewContext.delete)
            saveContext()
        }
    }
    
    private func saveContext(){
        do{
            try viewContext.save()
        }catch{
            let error = error as NSError
            fatalError("Error! \(error)")
        }
    }
    
    private func addTask(){
        withAnimation{
            let newTask = Task(context: viewContext)
            newTask.title = "New Task \(Date())"
            newTask.date = Date()
            
            saveContext()
        }
    }
    
    private func addTaskManual(localTitle: String, localDate: Date){
        //var localTitle: String
        //var localDate: Date
        withAnimation{
            let newTask = Task(context: viewContext)
            newTask.title = localTitle
            newTask.date = localDate
            
            saveContext()
        }
    }
    
}

struct AddTaskView: View {
    @State private var taskName: String = ""
    @State private var isEditing = false
    
    @State private var chosenColor = Color.black
    
    @Environment(\.presentationMode) var presentationMode
    
    @Environment(\.managedObjectContext)public var viewContext
    
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    Section(header: Text("Task Name")){
//                        TextField("Task Name", text: $taskName){ isEditing in
//                            self.isEditing = isEditing
//                        }
                        TextField("Enter Task Name", text: $taskName)
            
                    }
                    Section(header: Text("Pick a color")){
                        //Text(self.taskName)
                        ColorPicker("Choose a color ",selection: $chosenColor)
                    }
                    .foregroundColor(chosenColor)
                }.navigationBarTitle(Text("Add Task"))
                .navigationBarItems(
                    leading: Button("Cancel"){
                        self.presentationMode.wrappedValue.dismiss()
                    },
                    trailing: Button("Done"){
                        self.presentationMode.wrappedValue.dismiss()
                        withAnimation{
                            let newTask = Task(context: viewContext)
//                            newTask.title = localTitle
//                            newTask.date = localDate
                            newTask.title = self.taskName
                            newTask.date = Date()
                            saveContext()
                        }
                    }
                )
                
            }
        }
    }
    
    private func saveContext(){
        do{
            try viewContext.save()
        }catch{
            let error = error as NSError
            fatalError("Error! \(error)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
