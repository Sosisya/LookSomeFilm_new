//
//  CastAndCrewRouter.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 22.01.2024.
//

import UIKit

protocol CastAndCrewRouterProtocol: AnyObject {
    func goBack()
}

final class CastAndCrewRouter {

    weak var viewController: UIViewController?

    func goBack() {
        viewController?.dismiss(animated: true)
    }
}
