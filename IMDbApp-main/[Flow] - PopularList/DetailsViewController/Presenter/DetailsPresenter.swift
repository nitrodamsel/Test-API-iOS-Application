//
//  DetailsPresenter.swift
//  IMDbApp
//
//  Created by Billy Joel on 17.01.2024.
//

import Foundation

protocol DetailsPresenterProtocol {
    func presentDetailsModel(_ detailsModel: DetailsModel)
}

final class DetailsPresenter: DetailsPresenterProtocol {
    
    weak var viewController: DetailsViewControllerProtocol?
    
    func presentDetailsModel(_ detailsModel: DetailsModel) {
        
        let titleOrName = detailsModel.title ?? detailsModel.name ?? "Unkown"
        var updatedDetailsModel = detailsModel
        updatedDetailsModel.title = titleOrName
        
        let genreNames = detailsModel.genres?.map { $0.name }.joined(separator: ", ")
        let revenueDisplay: String
        
        if let revenue = detailsModel.revenue, revenue > 0 {
            revenueDisplay = formatCurrency(revenue)
        } else {
            revenueDisplay = "-"
        }
        let displayDate = detailsModel.releaseDate ?? detailsModel.firstAirDate ?? "Unkown"
    
        var collectionData: [DetailsCollectionViewCellViewModel] = []
        
        if !displayDate.isEmpty {
            let viewModel = DetailsCollectionViewCellViewModel(iconName: "date", title: String(displayDate.prefix(4)))
            collectionData.append(viewModel)
        }
        
       var displayRuntime = ""
        
        if let runtime = detailsModel.runtime {
            displayRuntime = convertDate(minutes: runtime)
        } else if let episodeRuntime = detailsModel.episodeRuntime, !episodeRuntime.isEmpty {
            let totalRuntime = episodeRuntime.reduce(0, +)
            displayRuntime = totalRuntime > 60 ? convertDate(minutes: totalRuntime) : "\(totalRuntime) min"
        }
        
        if !displayRuntime.isEmpty {
            let viewModel = DetailsCollectionViewCellViewModel(iconName: "watch", title: displayRuntime)
            collectionData.append(viewModel)
        }
        viewController?.displayDetailsModel(updatedDetailsModel, genreNames: genreNames ?? "", revenueText: revenueDisplay, collectionData: collectionData)
    }
    
    private func formatCurrency(_ value: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$ "
        formatter.maximumFractionDigits = 0
        formatter.usesGroupingSeparator = true
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: NSNumber(value: value)) ?? "$0"
    }
    private func convertDate(minutes: Int) -> String {
        let hours = minutes / 60
        let remainingMinutes = minutes % 60
        return String(format: "%02d:%02d", hours, remainingMinutes)
    }
}
