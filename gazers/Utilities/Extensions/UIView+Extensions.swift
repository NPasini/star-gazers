//
//  UIView+Extensions.swift
//  gazers
//
//  Created by Nicolò Pasini on 21/03/21.
//

import UIKit

extension UIView {

    /// Returns the *Nib* file with the same name of the current view class.
    ///
    /// - Returns: A `UINib`object.
    /// - Parameter fromBundle: The bundle associated with the view.
    ///
    /// This method tries to infer the right bundle in case none is specified.
    static func nib(fromBundle: Bundle? = nil) -> UINib {
        let nibName = String(describing: self)
        let bundle = fromBundle ?? Bundle(for: self)
        return UINib(nibName: nibName, bundle: bundle)
    }

    /// Instantiates an object using a *Nib* file with the same name as the current view class.
    ///
    /// - Parameters:
    ///   - owner: The object to use as the owner of the nib file.
    ///   - bundle: The bundle associated with the view.
    ///   - options: Nib options to be used while instantiating the view.
    /// - Returns: An object of the current class.
    static func instantiateFromNib(withOwner owner: Any? = nil, bundle: Bundle? = nil, options: [UINib.OptionsKey : Any]? = nil) -> Self? {
        return nib(fromBundle: bundle).instantiate(withOwner: owner, options: options).first as? Self
    }

    /// Inflates a view of a specific type into another view instantiating it from a xib file.
    ///
    /// - Parameters:
    ///   - type: Type of the view to inflate.
    ///   - owner: The object to use as the owner of the nib file.
    ///   - bundle: The bundle associated with the view.
    ///   - options: Nib options to be used while instantiating the view.
    ///   - contentView: View in which to inflate the newly created one.
    ///   - referenceToSafeArea: Boolean indicating if the constraints have to be related to the safe area (if available).
    /// - Returns: The object representing the View inflated.
    static func Inflate<T: UIView>(type: T.Type, owner: Any?, bundle: Bundle? = nil, options: [UINib.OptionsKey : Any]? = nil, inside contentView: UIView, referenceToSafeArea: Bool = false) -> T? {
        guard let view = type.instantiateFromNib(withOwner: owner, bundle: bundle, options: options) else { return nil }

        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)

        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            view.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        return view
    }
}
