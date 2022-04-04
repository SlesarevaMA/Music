//
//  PresentationAssemlby.swift
//  Music
//
//  Created by Margarita Slesareva on 04.04.2022.
//

import UIKit

final class ViewControllerFactory {
    
    func getMasterViewController() -> UIViewController {
        let masterController = SongsMasterViewController(
            requestService: ServiceAssembly.albumRequestService,
            viewControllerFactory: self
        )
        return UINavigationController(rootViewController: masterController)
    }
    
    func getDetailViewcotroller() -> SongDetailViewController {
        let songRequestService = ServiceAssembly.songRequestService
        let detailViewController = SongDetailViewController(songRequestService: songRequestService)
        return detailViewController
    }
}
