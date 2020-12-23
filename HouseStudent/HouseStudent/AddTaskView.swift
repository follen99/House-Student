//
//  AddTaskView.swift
//  CoreDataExample
//
//  Created by ranaurogiuliano on 22/12/2020.
//

import SwiftUI

struct AddTaskViewSTOP: View {
    @State private var taskName: String = ""
    @State private var isEditing = false
    
    @State private var chosenColor = Color.black
    
    @Environment(\.presentationMode) var presentationMode
    
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
                        
                    }
                )
                
            }
        }
    }
    
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}


