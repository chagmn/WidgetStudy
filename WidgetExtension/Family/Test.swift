//
//  Test.swift
//  Study_Widget
//
//  Created by ChangMin on 2022/11/08.
//

import SwiftUI

@available(iOS 16.0, *)
struct Test: View {
    var body: some View {
        
        VStack(
            alignment: .leading
        ) {
            HStack {
                Circle()
                    .frame(
                        width: 36
                    )
                
                Text("김이름")
                    .frame(
                        minWidth: 100,
                        maxWidth: 300,
                        alignment: .leading
                    )
                
            }
            
            Divider()
                .gridCellUnsizedAxes(.horizontal)
            
            VStack(
                alignment: .leading
            ) {
                Text("즐겨찾는 프로젝트")
                
                HStack {
                    ForEach(0..<14) { i in
                        Circle()
                            .frame(width: 32,
                                   height: 32)
                    }
                }
            }
        }
        .padding(.all, 8)
        .background(Color.yellow)
    }
}

@available(iOS 16.0, *)
struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
