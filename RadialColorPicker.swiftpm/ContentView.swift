import SwiftUI

struct ContentView: View 
{
    @State private var current: Color = .red
    
    var body: some View
    {
        ZStack {
            LinearGradient(colors: [current, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                RadialColorPicker(color: $current)
            }
            .padding(100)
        }
    }
}
