
//
//  ChartView.swift
//  StockSimulator
//
//  Created by Christopher Walter on 3/24/22.
//

import SwiftUI

struct ChartView: View {
    
//    @ObservedObject var vm = ChartViewModel()
    @StateObject var vm: ChartViewModel = ChartViewModel()
    
    @State private var animateChart = false
    @State private var showLoader = false
    @State private var trimValue: CGFloat = 0
    
    @State private var showingErrorAlert = false
    @State private var errorMessage = ""
    
    @State private var selectedTimeInterval = "1mo"
    
    // Indicator Stats
    @State var currentDateTime = ""
    @State var currentClose = ""
    @State var currentVolume = ""
    
    @State var offset: CGSize = .zero // this is the offset of the ball on the indicator bar from the bottom left corner of the chart
    @State var showPlot = false
    @State var translation: CGFloat = 0
    @State var index: Int = 0
    
    
    var timeRanges = ["1d","5d","1mo","6mo","ytd","1y","max"]

    var symbol: String
    
    init(symbol: String)
    {
        // have to convert symbol into a new form. the when the symbol is ^DJI -> %5EDJI. I do not know why, but I need to convert it to make it work with the API. also CL=F -> CL%3DF
        if symbol.contains("^") {
            let result = symbol.replacingOccurrences(of: "^", with: "%5E")
            self.symbol = result
        }
        else if symbol.contains("=") {
            let result = symbol.replacingOccurrences(of: "=", with: "%3D")
            self.symbol = result
        }
        else {
            self.symbol = symbol
        }

    }
    
    var body: some View {
        GeometryReader { gr in
            let height = gr.size.height
            let width = (gr.size.width) / CGFloat(vm.closeData.count - 1)
            let points = getPoints(width: width, totalHeight: height - 94) // subtracting 94 to remove the rangepicker, barChart, and dateLabels
            
            VStack {
                rangePicker
                ZStack {
                    linegraph
                        .background(chartBackground)
                        .overlay(chartYAxis.padding(.horizontal,4).foregroundColor(Color.theme.secondaryText), alignment: .leading)
                        .overlay(alignment: .bottomLeading) {
                            DragIndicator(height: height, points: points)
                                .padding(.horizontal, 4)
                                .frame(width: 80, height: height - 94) // subtracting 94 to remove the rangepicker, barChart, and dateLabels
                                .offset(x: -40)
                                .offset(offset)
                                .opacity(showPlot ? 1 : 0)
//                                .background(Color.gray.opacity(0.5))
                            
                        }
                        .overlay(alignment: .bottomLeading) {
                            indicatorStats
                                .frame(width: 150, height: height - 94, alignment: .center) // subtracting 94 to remove the rangepicker, barChart, and dateLabels
//                                .offset(x: -40)
                                .offset(CGSize(width: index > (vm.closeData.count / 2) ? offset.width - 160: offset.width + 10, height: offset.height ))
                                .opacity(showPlot ? 1 : 0)
                        }
                        .onAppear(perform: {
                            loadData()
                        })
                    if showLoader {
                        ChartLoader()
                    }
                }
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            withAnimation {
                                showPlot = true
                            }
                            updateDragIndactorData(value: value, width: width, points: points)
                        })
                        .onEnded({ value in
                            withAnimation {
                                showPlot = false
                            }
                            
                        })
                )
                volumeBarChart(width: width)
                
                chartDateLabels
                    .foregroundColor(Color.theme.secondaryText)
                    .padding(.horizontal, 4)
            }
            .frame(width: gr.size.width, height: gr.size.height)
            .font(.caption)
            .foregroundColor(Color.theme.secondaryText)
            .alert(isPresented: $showingErrorAlert) {
                Alert(title: Text("Error"), message: Text("\(errorMessage)"), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
//        ChartView(stockSnapshot: StockSnapshot())
        
        ChartView(symbol: "AAPL")
            .frame(width: 350, height: 400)
//            .preferredColorScheme(.dark)
            
    }
}

extension ChartView {
    
    private func loadData()
    {
        showLoader = true
        animateChart = false
        trimValue = 0
        vm.loadData(symbol: symbol, range: selectedTimeInterval) {
            chartDataResult in
            switch chartDataResult {
            case .success(_):
                showLoader = false
                withAnimation(.easeInOut(duration: 2)) {
                    animateChart = true
                }
            case .failure(let error):
                errorMessage = error
                showingErrorAlert = true
                showLoader = false
            }
        }
    }
    
    private var rangePicker: some View {
        Picker("Time Interval", selection: $selectedTimeInterval) {
            ForEach(timeRanges, id: \.self) {
                Text($0)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .onChange(of: selectedTimeInterval) { value in
            self.index = 0 // reset the index so that it prevents an app crash
            loadData()
        }
    }
    
    private var chartBackground: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }