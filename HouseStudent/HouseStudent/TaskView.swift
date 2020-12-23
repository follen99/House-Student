import SwiftUI

struct TaskView: View {
    var title: String
    var date: Date
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        //formatter.dateStyle = .long
        formatter.dateFormat = "d MMM y, HH:mm:ss"
        return formatter
    }
    
    
    var body: some View {
        HStack{
            //informazioni
            VStack{
                Text(title)
                    .font(.title)
                    .padding(5)
                    //.offset(x: -50, y: -30)
                    

                Text(dateFormatter.string(from: date))
                    .padding(5)
            }
                .offset(x: -70, y: 0)
                .frame(width: 350, height: 120, alignment: .center)
                .background(Color("ShyGray"))
                .cornerRadius(33)
                .shadow(color: .gray, radius: 4, x: 7, y: 7)
                
            }
            //toggle
        }
}

struct TaskView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        TaskView(title: "Sample title", date: Date())
    }
}



