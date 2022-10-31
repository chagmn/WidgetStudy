//
//  TaskView.swift
//  WidgetExtensionExtension
//
//  Created by ChangMin on 2022/10/31.
//

import SwiftUI

struct TaskView: View {
    var body: some View {
        HStack {
            Circle()
                .foregroundColor(.green)
                .frame(width: 12)
            
            Text("업무명")
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
    }
}
