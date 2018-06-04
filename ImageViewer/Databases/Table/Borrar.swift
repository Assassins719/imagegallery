//
//  borrar.swift
//  ImageViewer
//
//  Created by Admin on 5/31/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import SQLite

class Borrar {
    var unInt: Int64
    
    init(withRow row_item: Row) {
        unInt = row_item[Borrar_Table.unInt]
    }
    
    init(withMergedRow row_item: Row) {
        unInt = row_item[Borrar_Table.Borrar[Borrar_Table.unInt]]
        
    }
    
    var debug :String {
        return "\(unInt)"
    }
    
}

class Borrar_Table {
    static let Borrar = Table("borrar")
    
    static let unInt = Expression<Int64>("unInt")
}

func tester_Borrar_Table() {
    do {
        let dd = try StoryDatabase.shared.db.prepare(Borrar_Table.Borrar)
        for ddItem in dd {
            let dde = Borrar(withRow: ddItem)
            print("dde: \(dde.debug)")
        }
    } catch {
        print("\(error)")
    }
}
