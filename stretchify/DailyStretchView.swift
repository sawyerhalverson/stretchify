import SwiftUI

struct DailyStretchView: View {
    var body: some View {
        NavigationView {
            VStack {
                
                Spacer()

                Text("How long do you want to stretch for?")
                    .font(.title)
                    .padding()
                
                
                NavigationLink(destination: PreStretchView(minutes: 3)) {
                    Text("3 minutes")
                }
                .buttonStyle(BlueButtonStyle()) // Apply button style
                
                NavigationLink(destination: PreStretchView(minutes: 5)) {
                    Text("5 minutes")
                }
                .buttonStyle(BlueButtonStyle()) // Apply button style
                
                NavigationLink(destination: PreStretchView(minutes: 10)) {
                    Text("10 minutes")
                }
                .buttonStyle(BlueButtonStyle()) // Apply button style
                
                Spacer() // Add spacer to push content to the top
            }
            .padding(.horizontal) // Add horizontal padding
            .navigationBarTitle("") // Hide the navigation bar title
            .navigationBarHidden(true) // Hide the navigation bar
        }
    }
}

// Define a custom button style
struct BlueButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .font(.title)
            .frame(maxWidth: .infinity) // Allow button to expand horizontally
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.vertical, 10) // Add vertical padding around the text
    }
}

struct DailyStretchView_Previews: PreviewProvider {
    static var previews: some View {
        DailyStretchView()
    }
}
