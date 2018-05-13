//
//  ViewController.swift
//
//  Created by Manuel Bulos on 5/8/18.
//  Copyright © 2018 Bulos. All rights reserved.
//

import UIKit
import Foundation

open class UITicketViewController: UIViewController {

    @IBOutlet public weak var ticketViewContainer = UIView()
    
    var appearance = TicketViewAppearance.shared()
    
    open var ticketsTableView = UITableView()
    open var tickets = [Ticket]()
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = appearance.dateFormat
        return formatter
    }()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        registerCells()
    }
    
    override open func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        ticketsTableView.reloadData()
    }
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let ticketViewContainer = self.ticketViewContainer else { return }
        ticketsTableView.translatesAutoresizingMaskIntoConstraints = false
        ticketsTableView.frame = ticketViewContainer.bounds
        ticketsTableView.frame.origin.x = appearance.ticketViewContainerMargin
        ticketsTableView.frame.origin.y = appearance.ticketViewContainerMargin
        ticketsTableView.frame.size.width = ticketViewContainer.frame.width - (appearance.ticketViewContainerMargin * 2)
        ticketsTableView.frame.size.height = ticketViewContainer.frame.height - (appearance.ticketViewContainerMargin * 2)
        ticketViewContainer.addSubview(ticketsTableView)
    }
    
    func registerCells() {
        ticketsTableView.register(TopTicketView.self, forCellReuseIdentifier: "TopTicketViewCell")
        ticketsTableView.register(MidTicketView.self, forCellReuseIdentifier: "MidTicketViewCell")
        ticketsTableView.register(MultipleMidTicketView.self, forCellReuseIdentifier: "MultipleMidTicketViewCell")
        ticketsTableView.register(BottomTicketView.self, forCellReuseIdentifier: "BottomTicketViewCell")
        ticketsTableView.register(SingleBottomTicketView.self, forCellReuseIdentifier: "SingleBottomTicketViewCell")
    }

    func setUpTableView() {
        ticketsTableView.delegate = self
        ticketsTableView.dataSource = self
        
        ticketsTableView.separatorStyle = .none
        ticketsTableView.backgroundColor = .clear
        ticketsTableView.showsVerticalScrollIndicator = false
        ticketsTableView.showsHorizontalScrollIndicator = false
    }

}

extension UITicketViewController: UITableViewDelegate {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return tickets.count
    }
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = appearance.cellsHeight
        guard let numberOfStopOvers = tickets[indexPath.section].stopOvers?.count else { return height }
        if indexPath.row == numberOfStopOvers {
            return numberOfStopOvers <= 1 ? height + 8:height
        } else {
            return height
        }
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (tickets[section].stopOvers?.count ?? 0) + 1
    }
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < 1 {
            print(tickets[indexPath.section].departureCityLong)
        } else {
            print(tickets[indexPath.section].stopOvers![indexPath.row - 1].departureCity)
        }
    }
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !appearance.animated { return }
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.4) {
            cell.transform = CGAffineTransform.identity
        }
    }
}

extension UITicketViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let topCell = tableView.dequeueReusableCell(withIdentifier: "TopTicketViewCell") as? TopTicketView else {
            return UITableViewCell()
        }
        guard let midCell = tableView.dequeueReusableCell(withIdentifier: "MidTicketViewCell") as? MidTicketView else {
            return UITableViewCell()
        }
        guard let multipleMidCell = tableView.dequeueReusableCell(withIdentifier: "MultipleMidTicketViewCell") as? MultipleMidTicketView else {
            return UITableViewCell()
        }
        guard let bottomCell = tableView.dequeueReusableCell(withIdentifier: "BottomTicketViewCell") as? BottomTicketView else {
            return UITableViewCell()
        }
        guard let singleBottomCell = tableView.dequeueReusableCell(withIdentifier: "SingleBottomTicketViewCell") as? SingleBottomTicketView else {
            return UITableViewCell()
        }
        let lastRow = tableView.numberOfRows(inSection: indexPath.section) - 1
        
        switch indexPath.row {
        case 0:
            guard let _ = tickets[indexPath.section].stopOvers?[indexPath.row] else { return UITableViewCell() }
            topCell.departureCityShortLabel.text = tickets[indexPath.section].departureCityShort
            topCell.departureCityLongLabel.text = tickets[indexPath.section].departureCityLong
            topCell.arrivalCityShortLabel.text = tickets[indexPath.section].arrivalCityShort
            topCell.arrivalCityLongLabel.text = tickets[indexPath.section].arrivalCityLong
            return topCell
            
        case lastRow:
            guard let ticket = tickets[indexPath.section].stopOvers?[indexPath.row - 1] else { return UITableViewCell() }
            bottomCell.airlineLogo = ticket.airlineLogo
            bottomCell.departureCity = ticket.departureCity.shortenName()
            bottomCell.departureTime = dateFormatter.string(from: ticket.departureTime)
            bottomCell.arrivalCity = ticket.arrivalCity.shortenName()
            bottomCell.arrivalTime = dateFormatter.string(from: ticket.arrivalTime)
            bottomCell.airlineName = ticket.airlineName
            
            singleBottomCell.airlineLogo = ticket.airlineLogo
            singleBottomCell.departureCity = ticket.departureCity.shortenName()
            singleBottomCell.departureTime = dateFormatter.string(from: ticket.departureTime)
            singleBottomCell.arrivalCity = ticket.arrivalCity.shortenName()
            singleBottomCell.arrivalTime = dateFormatter.string(from: ticket.arrivalTime)
            singleBottomCell.airlineName = ticket.airlineName
            
            return tickets[indexPath.section].stopOvers?.count ?? 0 <= 1 ? singleBottomCell:bottomCell
            
        case 1:
            guard let ticket = tickets[indexPath.section].stopOvers?[indexPath.row - 1] else { return UITableViewCell() }
            midCell.airlineLogo = ticket.airlineLogo
            midCell.departureCity = ticket.departureCity.shortenName()
            midCell.departureTime = dateFormatter.string(from: ticket.departureTime)
            midCell.arrivalCity = ticket.arrivalCity.shortenName()
            midCell.arrivalTime = dateFormatter.string(from: ticket.arrivalTime)
            midCell.airlineName = ticket.airlineName
            return midCell
            
        default:
            guard let ticket = tickets[indexPath.section].stopOvers?[indexPath.row - 1] else { return UITableViewCell() }
            multipleMidCell.airlineLogo = ticket.airlineLogo
            multipleMidCell.departureCity = ticket.departureCity.shortenName()
            multipleMidCell.departureTime = dateFormatter.string(from: ticket.departureTime)
            multipleMidCell.arrivalCity = ticket.arrivalCity.shortenName()
            multipleMidCell.arrivalTime = dateFormatter.string(from: ticket.arrivalTime)
            multipleMidCell.airlineName = ticket.airlineName
            return multipleMidCell
        }
    }
}
