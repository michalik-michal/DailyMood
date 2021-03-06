//
//  DaysView.swift
//  DailyMood
//
//  Created by MacOS on 14/06/2022.
//

import SwiftUI
import RealmSwift

struct DaysView: View {
    @EnvironmentObject var realmService: RealmService
    
    var body: some View {
        
        VStack{
            topStack
            ScrollView{
                VStack(spacing: 0){
                    ForEach(realmService.dailyMoods.sorted(by: {$0.date > $1.date}), id: \.id){
                        day in
                        if !day.isInvalidated{
                            DayRowView(dayMood: day)
                        }
                    }
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: Color.primary.opacity(0.1), radius: 10, x: 0, y: 5)
            Spacer()
        }
        .padding()
        
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct DaysView_Previews: PreviewProvider {
    static var previews: some View {
        DaysView().environmentObject(RealmService())
    }
}

extension DaysView{
    
    var topStack: some View{
        HStack{
            Text("Daily Mood")
                .font(.largeTitle).bold()
                .foregroundColor(.black)
            Spacer()
            NavigationLink {
                AddDayView().environmentObject(realmService)
                    
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.moodBlue)
            }
        }
    }
    
}
