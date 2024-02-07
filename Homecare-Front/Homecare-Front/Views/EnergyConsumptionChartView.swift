//
//  EnergyConsumptionChartView.swift
//  Homecare-Front
//
//  Created by Luis Cedillo M on 06/02/24.
//

import SwiftUI
import Charts

//define petdata
struct PetData {
    let name: String
    let population: Double

    static let catExample = [PetData(name: "cat", population: 50),
                             PetData(name: "cat", population: 50),
                             PetData(name: "cat", population: 300)]
    static let dogExamples = [PetData(name: "dog", population: 150),
                              PetData(name: "dog", population: 250),
                              PetData(name: "dog", population: 350)]
}

struct EnergyConsumptionChartView: View {
    let catData = PetData.catExample
        let dogData = PetData.dogExamples
        var catTotal: Double {
            catData.reduce(0) { $0 + $1.population }
        }

        var dogTotal: Double {
            dogData.reduce(0) { $0 + $1.population }
        }

        var data: [(type: String, amount: Double)] {
            [(type: "cat", amount: catTotal),
             (type: "dog", amount: dogTotal)
            ]
        }

        var maxPet: String? {
            data.max { $0.amount < $1.amount }?.type
        }

        var body: some View {
            Chart(data, id: \.type) { dataItem in
                SectorMark(angle: .value("Type", dataItem.amount),
                           innerRadius: .ratio(0.5),
                           angularInset: 1.5)
                    .cornerRadius(5)
                    .opacity(dataItem.type == maxPet ? 1 : 0.5)
            }
            .frame(height: 200)
        }
}

//preview
struct EnergyConsumptionChartView_Previews: PreviewProvider {
    static var previews: some View {
        EnergyConsumptionChartView()
    }
}
