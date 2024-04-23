import SwiftUI

struct ContentView: View {
    @State private var selectedColor = Color.blue

    var body: some View {
        NavigationView {
            ZStack {

                VStack(spacing: 40) {
                    // Button for Daily Stretch
                    NavigationLink(destination: DailyStretchView()) {
                        Text("Daily Stretch")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    // Button for Custom Stretch
                    NavigationLink(destination: StretchesView()) {
                        Text("Custom Stretch")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()


                
                Text("stretchify")
                    .foregroundColor(.black) // Ensure text color contrasts with background
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
