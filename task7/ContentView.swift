//
//  ContentView.swift
//  task7
//
//  Created by Hiroshi.Nakai on 2021/02/18.
//

import SwiftUI

struct ContentView: View {

    @State private var selection = 0
    @State private var textArray = Array(repeating: "", count: 4)
    @State private var total:Int?

    var body: some View {

        VStack {
            TabView(selection: $selection) {
                comView(color: Color.red, tabTitle: "加算タブ", isAdd: true)
                comView(color: Color.green, tabTitle: "減算タブ", isAdd: false)
            }

        }
    }
}

// 共通 View
struct comView: View {

    @State private var textArray = Array(repeating: "", count: 2)
    @State private var total:Int?

    var color: Color
    var tabTitle: String
    var isAdd: Bool

    var body: some View {
        ZStack {
            color
                .edgesIgnoringSafeArea(.all)

            VStack {

                InputView(text: $textArray[0])
                    .padding(10)
                InputView(text: $textArray[1])
                    .padding(5)

                Button("計算") {
                    guard let num1 = Int(textArray[0]) else {
                        return
                    }

                    guard let num2 = Int(textArray[1]) else {
                        return
                    }

                    total = isAdd ? num1 + num2 : num1 - num2

                    UIApplication.shared.closeKeyboard()
                }.padding()

                HStack {
                    Text(String(total ?? 0))
                }

                Spacer()
            }
        }.tabItem {
            Text(tabTitle)
        }.tag(isAdd ? 0 : 1)
    }
}


struct InputView: View {
    @Binding var text: String

    var body: some View {
        TextField("", text: $text)
            .keyboardType(.numberPad)
            .frame(width: 100, height: 30)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.black.opacity(0.5), lineWidth: 1)
            )
    }
}

extension UIApplication {
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
