import SwiftUI

struct StretchesView: View {
    let allStretches: [Stretch]
    @State private var selectedTags: Set<String> = []

    init() {
        if let data = try? Data(contentsOf: Bundle.main.url(forResource: "stretches", withExtension: "json")!) {
            do {
                self.allStretches = try JSONDecoder().decode([Stretch].self, from: data)
            } catch {
                print("Error decoding JSON: \(error)")
                self.allStretches = []
            }
        } else {
            print("Error loading JSON file")
            self.allStretches = []
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                // Title
                Text("Stretches")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()

                // Body parts selection
                HStack {
                    RadioButton(text: "Full Body", isSelected: selectedTags.contains("Full Body")) {
                        if selectedTags.contains("Full Body") {
                            selectedTags.remove("Full Body")
                        } else {
                            selectedTags.removeAll()
                            selectedTags.insert("Full Body")
                        }
                    }

                    RadioButton(text: "Upper Body", isSelected: selectedTags.contains("Upper Body")) {
                        if selectedTags.contains("Upper Body") {
                            selectedTags.remove("Upper Body")
                        } else {
                            selectedTags.removeAll()
                            selectedTags.insert("Upper Body")
                        }
                    }

                    RadioButton(text: "Lower Body", isSelected: selectedTags.contains("Lower Body")) {
                        if selectedTags.contains("Lower Body") {
                            selectedTags.remove("Lower Body")
                        } else {
                            selectedTags.removeAll()
                            selectedTags.insert("Lower Body")
                        }
                    }
                }
                .padding()

                // What do you want to stretch?
                Text("What do you want to stretch?")
                    .font(.headline)
                    .padding(.bottom, 5)

                // Radio buttons for specific stretches
                VStack(alignment: .leading) {
                     ForEach(allStretches.flatMap { $0.tags }, id: \.self) { tag in
                         if !["Full Body", "Upper Body", "Lower Body"].contains(tag) {
                             RadioButton(text: tag, isSelected: selectedTags.contains(tag)) {
                                 if selectedTags.contains(tag) {
                                     selectedTags.remove(tag)
                                 } else {
                                     selectedTags.insert(tag)
                                 }
                             }
                         }
                     }
                 }

                Spacer()

                // Start Stretch Session button
                NavigationLink(destination: StretchSessionView(selectedTags: Array(selectedTags), allStretches: allStretches.filter { stretch in
                    selectedTags.isEmpty || selectedTags.contains { tag in
                        stretch.tags.contains(tag)
                    }
                })) {
                    Text("Start Stretch Session")
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.bottom)
            }
            .navigationBarTitle("Stretches")
        }
    }
}

struct RadioButton: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                Text(text)
            }
            .foregroundColor(.primary)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct StretchSessionView: View {
    let selectedTags: [String]
    let allStretches: [Stretch]
    @State private var currentIndex = 0
    @State private var timerProgress: CGFloat = 1.0
    @State private var isCompleted = false

    @State private var filteredStretches: [Stretch] = []

    var body: some View {
        VStack {
            Spacer()

            VStack {
                if filteredStretches.isEmpty {
                    Text("No stretches available for the selected tags.")
                        .font(.headline)
                        .padding()
                } else if !isCompleted {
                    StretchView(stretch: filteredStretches[currentIndex])
                        .transition(.opacity)

                    GeometryReader { geometry in
                        Rectangle()
                            .foregroundColor(.blue)
                            .frame(width: geometry.size.width * timerProgress, height: 20)
                            .cornerRadius(2.5)
                    }
                    .padding()
                } else {
                    Text("Stretches Completed")
                        .font(.headline)
                        .padding(.bottom)
                }
            }
            .padding()

            Spacer()
        }
        .navigationBarTitle("Stretches")
        .onAppear {
            print("Selected Tags: \(selectedTags)")
            filteredStretches = computeFilteredStretches()
            startTimer()
        }

    }

    private func computeFilteredStretches() -> [Stretch] {
        if selectedTags.isEmpty {
            print("No selected tags. Returning all stretches.")
            return allStretches
        } else {
            let filtered = allStretches.filter { stretch in
                for tag in selectedTags {
                    if stretch.tags.contains(tag) {
                        return true
                    }
                }
                return false
            }
            print("Filtered Stretches: \(filtered)")
            return filtered
        }
    }

    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            DispatchQueue.main.async {
                self.timerProgress -= 0.1 / 4
            }
            if self.timerProgress <= 0 {
                if self.currentIndex < self.filteredStretches.count - 1 {
                    self.currentIndex += 1
                    self.timerProgress = 1.0
                } else {
                    timer.invalidate()
                    self.isCompleted = true
                }
            }
        }
    }
}

struct StretchView: View {
    let stretch: Stretch

    var body: some View {
        VStack(alignment: .leading) {
            Text(stretch.name)
                .font(.headline)
                .multilineTextAlignment(.leading)
            Text(stretch.description)
                .font(.body)
        }
        .padding()
    }
}

struct StretchesView_Previews: PreviewProvider {
    static var previews: some View {
        StretchesView()
    }
}
