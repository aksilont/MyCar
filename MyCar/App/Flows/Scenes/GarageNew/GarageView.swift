//
//  GarageView.swift
//  MyCar
//
//  Created by Aksilont on 05.06.2022.
//

import SwiftUI

struct GarageView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> GarageCollectionViewController {
        return GarageCollectionViewController()
    }

    func updateUIViewController(_ uiViewController: GarageCollectionViewController,
                                context: Context) {
    }
}

struct GarageView_Previews: PreviewProvider {
    static var previews: some View {
        GarageView()
    }
}
