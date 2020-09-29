//
//  EntityDetailsView.swift
//  Crepatura
//
//  Created by Thorax on 01.02.2020.
//  Copyright © 2020 Thorax. All rights reserved.
//

import SwiftUI

struct EntityDetailsView: View {
    let workoutSession: WorkoutSession
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

struct EntityDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let cd = CoreDataService()
        let first = cd.fetch().first
        EntityDetailsView(workoutSession: WorkoutSession())
    }
}
