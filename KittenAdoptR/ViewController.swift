//
//  ViewController.swift
//  KittenAdoptR
//
//  Created by Joe Susnick on 6/16/17.
//  Copyright © 2017 Joe Susnick. All rights reserved.
//

import UIKit

protocol URLOpener: class {
    func openURL(_ url: URL) -> Bool
}

extension UIApplication: URLOpener {}

class ViewController: UIViewController, UITableViewDelegate {
    private var dataSource = KittenDataSource()
    @IBOutlet weak var tableView: UITableView!
        {
        didSet {
            tableView.dataSource = dataSource
        }
    }

    var opener: URLOpener = UIApplication.shared

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if dataSource.kittens[indexPath.row].isAdoptable {
            return indexPath
        } else {
            return nil
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let kittenName = dataSource.kittens[indexPath.row].name

        guard let url = URL(string: "https://www.google.com/search?q=\(kittenName)") else {
            return
        }

        opener.openURL(url)
    }
}

