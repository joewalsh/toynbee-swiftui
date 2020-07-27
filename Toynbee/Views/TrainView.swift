import SwiftUI

struct TrainView: View {
    var train: Train
    var body: some View {
        let color = Color(train.line.code)
        HStack {
            Image("tram").foregroundColor(color)
            Text("\(train.line.code) \(train.id)").foregroundColor(color).bold()
        }
       
    }
}
