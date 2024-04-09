import SwiftUI

struct ContentView: View {
    @State private var selectedColor = Color.blue

    var body: some View {
        ZStack {
            Rectangle()
                .fill(selectedColor)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ColorPicker("Choose Theme", selection: $selectedColor)
                    .frame(width: 250, alignment: .trailing)
                    .padding()
                    .font(.custom("Pacifico-Regular", size: 24))
            }
            .controlSize(.regular)
            .background(
                Rectangle() // White box positioned behind the ColorPicker
                    .fill(Color.white)
                    .frame(width: 264.0, height: 50.0)
                    .cornerRadius(17.0)
            )
            
            Text("stretchify")
                .foregroundColor(.white) // Ensure text color contrasts with background
                .font(.system(size: 80)) // Increase font size for visibility
                .offset(y: 300) // Adjust offset to position it near the bottom!
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
