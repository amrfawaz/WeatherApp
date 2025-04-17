//
//  Font+Typography.swift
//
//
//  Created by Amr Abd-Elhakim on 17/04/2025.
//

import SwiftUI

public extension View {
    func typography(_ fontStyle: Style.Font, lineLimit: Int? = nil, removeTopPadding: Bool = false) -> some View {
        modifier(Typography(fontStyle: fontStyle, lineLimit: lineLimit, removeTopPadding: removeTopPadding))
    }
}

private struct Typography: ViewModifier {
    @Environment(\.sizeCategory) private var sizeCategory

    let fontStyle: Style.Font
    let lineLimit: Int?
    let removeTopPadding: Bool

    func body(content: Content) -> some View {
        let spacing = fontStyle.lineHeight.scaledSize - fontStyle.font.lineHeight
        let padding = spacing / 2

        return content
            .font(Font(fontStyle.font))
            .lineSpacing(spacing)
            .padding(
                EdgeInsets(
                    top: removeTopPadding ? -padding : padding,
                    leading: 0,
                    bottom: padding,
                    trailing: 0
                )
            )
            .lineLimit(lineLimit)
    }
}
