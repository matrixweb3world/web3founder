import SwiftUI

struct ChartView: View {
    let buyPercentage: Double
    let holdPercentage: Double
    let sellPercentage: Double
    let targetPrice: Double
    let estimatedReturn: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("What the Experts Say")
                .font(.headline)
            
            Text("16 Wall Street Analyst Ratings")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            HStack {
                Circle()
                    .fill(Color.green)
                    .frame(width: 50, height: 50)
                    .overlay(Text("BUY").foregroundColor(.white))
                
                VStack(alignment: .leading, spacing: 8) {
                    ProgressBar(value: buyPercentage, color: .green)
                    ProgressBar(value: holdPercentage, color: .yellow)
                    ProgressBar(value: sellPercentage, color: .red)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("\(Int(buyPercentage * 100))% Buy").foregroundColor(.green)
                    Text("\(Int(holdPercentage * 100))% Hold").foregroundColor(.yellow)
                    Text("\(Int(sellPercentage * 100))% Sell").foregroundColor(.red)
                }
            }
            
            Divider()
            
            HStack {
                VStack {
                    ZStack {
                        Circle()
                            .fill(Color.blue.opacity(0.1))
                            .frame(width: 50, height: 50)
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.blue)
                    }
                    Text("Target Price")
                        .font(.subheadline)
                    Text("$\(targetPrice, specifier: "%.2f")")
                        .font(.title2)
                        .bold()
                }
                
                Spacer()
                
                VStack {
                    ZStack {
                        Circle()
                            .fill(Color.green.opacity(0.1))
                            .frame(width: 50, height: 50)
                        Image(systemName: "chart.line.uptrend.xyaxis")
                            .foregroundColor(.green)
                    }
                    Text("Est Return")
                        .font(.subheadline)
                    Text("+\(estimatedReturn, specifier: "%.2f")%")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.green)
                }
            }
        }
        .padding()
    }
}

struct ProgressBar: View {
    var value: Double
    var color: Color
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: 8)
                    .opacity(0.3)
                    .foregroundColor(.gray)
                
                Rectangle()
                    .frame(width: CGFloat(value) * geometry.size.width, height: 8)
                    .foregroundColor(color)
            }
            .cornerRadius(4)
        }
        .frame(height: 8)
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(
            buyPercentage: 0.7,
            holdPercentage: 0.25,
            sellPercentage: 0.05,
            targetPrice: 117.25,
            estimatedReturn: 65.20
        )
        .previewLayout(.sizeThatFits)
    }
}
