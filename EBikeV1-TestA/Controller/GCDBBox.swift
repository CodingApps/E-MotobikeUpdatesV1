//
//  GCDBBox.swift
//  EBikeV1-TestA
//
//  Open Source
//
//  Copyright © 2022 Rick
//
//  Open Source, The MIT License (MIT)
//

import Foundation

func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
