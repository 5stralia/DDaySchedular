//
//  Item+Identifiable.swift
//  DDaySchedular
//
//  Created by Hoju Choi on 2022/06/20.
//

extension Item {
    public typealias ID = String
    public var id: ID {
        "\(String(describing: title))_\(String(describing: timestamp))_\(String(describing: reminders))"
    }
}
