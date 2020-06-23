//
//  NewCardView.swift
//  pointCard
//
//  Created by 郭冠杰 on 2020/6/6.
//  Copyright © 2020 郭冠杰. All rights reserved.
//

import SwiftUI

struct NewCardView: View {
    
    let word: [String]
    let backgroundColor: Color
    var chooseStatus = true
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing){
            
            
            Rectangle()
                .fill(backgroundColor)
                .frame(width: 120, height: 200)
                .overlay(
                    
                    VStack(spacing: 10){
                        Text(word[0])
                            .foregroundColor(.white)
                            .font(.custom("jf-openhuninn-1.1", size: 70))
//                            .font(.system(size: 70))
                        
                        Text(word[1])
                            .foregroundColor(.white)
                            .font(.custom("jf-openhuninn-1.1", size: 70))
//                            .font(.system(size: 70))
                    }
            )
            
            if chooseStatus == true {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.blue)
                    .offset(x: -8, y:-10)
            }
            
        }
        
    }
}

struct NewCardView_Previews: PreviewProvider {
    static var previews: some View {
        NewCardView(word: wordType[0], backgroundColor: colorType["紅"]!, chooseStatus: true)
    }
}
