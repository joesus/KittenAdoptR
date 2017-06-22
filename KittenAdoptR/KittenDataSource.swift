//
//  KittenDataSource.swift
//  KittenAdoptR
//
//  Created by Joe Susnick on 6/16/17.
//  Copyright © 2017 Joe Susnick. All rights reserved.
//

import UIKit

class KittenDataSource: NSObject, UITableViewDataSource {

    var kittens = [Kitten]()

    func numberOfSections(in tableView: UITableView) -> Int {
        return kittens.count > 0 ? 1 : 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kittens.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = kittens[indexPath.row].name

        if kittens[indexPath.row].isAdoptable {
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.accessoryType = .none
        }

        return cell
    }
}
