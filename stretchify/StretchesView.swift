import SwiftUI

struct StretchesView: View {
    let stretches: [Stretch] = Bundle.main.decode("stretches.json")
    @State private var currentIndex = 0
    @State private var timerProgress: CGFloat = 1.0
    @State private var isShowingContentView = false

    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text(stretches[currentIndex].name)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                Text(stretches[currentIndex].description)
                    .font(.body)
                
                GeometryReader { geometry in
                    Rectangle()
                        .foregroundColor(.blue)
                        .frame(width: geometry.size.width * timerProgress, height: 20)
                        .cornerRadius(2.5)
                }
            }
            .padding()
            Spacer()
            
            Button(action: {
                isShowingContentView = true
            }) {
                Text("Back to Home")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.bottom)
            .sheet(isPresented: $isShowingContentView, content: {
                ContentView()
            })
        }
        .navigationBarTitle("Stretches")
        .onAppear {
            startTimer()
        }
    }


    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if currentIndex < stretches.count - 1 {
                DispatchQueue.main.async {
                    self.timerProgress -= 0.1 / 15 // Decrease progress by 10% of total time (4 seconds)
                }
                if self.timerProgress <= 0 {
                    self.timerProgress = 1.0
                    currentIndex += 1
                }
            } else {
                timer.invalidate() // Stop the timer when all stretches have been shown
            }
        }
    }
}

struct StretchesView_Previews: PreviewProvider {
    static var previews: some View {
        StretchesView()
    }
}
