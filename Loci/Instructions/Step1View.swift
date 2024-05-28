import SwiftUI

struct Step1View: View {
    var body: some View {
        VStack {
            Text("Understanding the Path")
                .font(.largeTitle)
                .padding(.bottom, 15)

            Text("""
            - The memory palace is divided into multiple sections.
            - Each section represents a distinct part of the path that you will follow to memorize items.
            - There are 14 sections, with each sector containing 4 totems.
            - Visualize walking through these paths as you place your items.
            """)
            .padding(.bottom, 30)
            
            Color.clear
                .overlay {
                    Image("amongus_minimap")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 250)
                        .frame(width: 500)
//                        .offset(z: 250)
                }.padding(.bottom, 30)

            NavigationLink(destination: Step2View()) {
                Text("Next")
                    .padding()
                    .cornerRadius(10)
            }
        }
        .padding(70)
    }
}

#Preview {
    Step1View()
}