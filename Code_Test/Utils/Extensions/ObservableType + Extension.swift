//
//  ObservableType + Extension.swift
//  Code_Test
//
//  Created by Thinzar Soe on 9/8/22.
//

import Foundation
import RxSwift

struct IndexedElement<E> {
    
    let index: Int
    let element: E
}

extension ObservableType {
    
    static func indexedMerge<Payload>(
        _ sources: [Observable<Payload>]
    ) -> Observable<Element> where Element == IndexedElement<Payload> {
        let observables = sources.enumerated().map { index, source in
            source.map { IndexedElement(index: index, element: $0) }
        }
        return Observable.merge(observables)
    }
}

