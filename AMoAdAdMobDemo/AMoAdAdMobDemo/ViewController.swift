//
//  ViewController.swift
//  AMoAdAdMobDemo
//
//  Created by 菅原 清吾 on 2018/08/27.
//  Copyright © 2018年 com.amoad. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func pushViewController(withItem item: Item) {
        let vc = UIStoryboard(name: item.storyboardName, bundle: Bundle.main).instantiateInitialViewController()!
        vc.title = item.title
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        self.pushViewController(withItem: TopList.items[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TopList.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contentView", for: indexPath)
        (cell.viewWithTag(1) as! UILabel).text = TopList.items[indexPath.row].title
        return cell
    }
}

