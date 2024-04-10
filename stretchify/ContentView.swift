import SwiftUI

struct ContentView: View {
    @State private var selectedColor = Color.blue

    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .fill(selectedColor)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    ColorPicker("Choose Theme", selection: $selectedColor)
                        .frame(width: 180, alignment: .trailing)
                        .padding()
                  
                    
                    NavigationLink(destination: StretchesView()) {
                        Text("Stretch out")
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.blue)
                            .cornerRadius(10)
                    }
                }
                .controlSize(.regular)
                .background(
                    Rectangle() // White box positioned behind the ColorPicker
                        .fill(Color.white)
                        .frame(width: 264.0, height: 160.0)
                        .cornerRadius(17.0)
                )
                
                Text("stretchify")
                    .foregroundColor(.white) // Ensure text color contrasts with background
                    .font(.system(size: 80)) // Increase font size for visibility
                    .offset(y: 300) // Adjust offset to position it near the bottom!
            }
            .navigationBarTitle("") // Hide the navigation bar title
            .navigationBarHidden(true) // Hide the navigation bar
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
