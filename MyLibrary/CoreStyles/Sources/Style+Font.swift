//
//  Style+Font.swift
//  
//
//  Created by Amr Abd-Elhakim on 17/04/2025.
//

import SwiftUI

public extension Style {
    enum Font {
        /// theme-heading-01
        case heading01
        /// theme-heading-02
        case heading02
        /// theme-heading-03
        case heading03

        /// theme-subheading
        case subheading

        /// theme-button-01
        case button01
        /// theme-button-02
        case button02
        /// theme-button-03
        case button03

        /// theme-body-01
        case body01
        /// theme-body-02
        case body02

        /// theme-callout
        case callout

        /// theme-caption-01
        case caption01
        /// theme-caption-02
        case caption02

        case display05

        /// theme-small-01
        case small01
        /// theme-small-02
        case small02

        /// theme-tiny-01
        case tiny01
        /// theme-tiny-02
        case tiny02

        /// theme-text-input-01
        case textInput01
    }
}

public extension Style.Font {
    var font: UIFont {
        UIFont.systemFont(ofSize: fontSize.scaledSize, weight: fontWeight.value)
    }

    var size: CGFloat {
        fontSize.rawValue
    }

    internal var lineHeight: Size {
        switch self {
        case .heading01:
            .nine
        case .heading02:
            .eight
        case .heading03:
            .seven
        case .subheading:
            .seven
        case .button01:
            .six
        case .button02:
            .six
        case .button03:
            .six
        case .body01:
            .six
        case .body02:
            .six
        case .callout:
            .six
        case .caption01:
            .six
        case .caption02:
            .six
        case .display05:
            .twentyFive
        case .textInput01:
            .six
        case .small01:
            .four
        case .small02:
            .four
        case .tiny01:
            .four
        case .tiny02:
            .four
        }
    }

    var lineSpacing: CGFloat {
        lineHeight.scaledSize - font.lineHeight
    }

    private var fontSize: Size {
        switch self {
        case .heading01:
            .eight
        case .heading02:
            .seven
        case .heading03:
            .five
        case .subheading:
            .four
        case .textInput01:
            .four
        case .button01:
            .three
        case .button02:
            .three
        case .button03:
            .three
        case .body01:
            .three
        case .body02:
            .three
        case .callout:
            .three
        case .caption01:
            .three
        case .caption02:
            .three
        case .display05:
            .twenty
        case .small01:
            .two
        case .small02:
            .two
        case .tiny01:
            .one
        case .tiny02:
            .one
        }
    }

    private var fontWeight: FontWeight {
        switch self {
        case .heading01:
            .pro1
        case .heading02:
            .pro1
        case .heading03:
            .pro1
        case .subheading:
            .pro1
        case .textInput01:
            .pro2
        case .button01:
            .pro0
        case .button02:
            .pro1
        case .button03:
            .pro1
        case .body01:
            .pro2
        case .body02:
            .pro1
        case .callout:
            .pro1
        case .caption01:
            .pro2
        case .caption02:
            .pro1
        case .display05:
            .pro1
        case .small01:
            .pro2
        case .small02:
            .pro1
        case .tiny01:
            .pro2
        case .tiny02:
            .pro1
        }
    }
}

// MARK: - Font Weights

private enum FontWeight {
    /// .extrabold
    case pro0
    /// .semibold
    case pro1
    /// .regular
    case pro2

    // we use it only when we use system font in the app
    var value: UIFont.Weight {
        switch self {
        case .pro0:
            .bold
        case .pro1:
            .semibold
        case .pro2:
            .regular
        }
    }
}

// MARK: - Font Sizes & Line Height

enum Size: CGFloat {
    /// 10 px
    case one = 10
    /// 12 px
    case two = 12
    /// 14 px
    case three = 14
    /// 16 px
    case four = 16
    /// 18 px
    case five = 18
    /// 20 px
    case six = 20
    /// 24 px
    case seven = 24
    /// 28 px
    case eight = 28
    /// 32 px
    case nine = 32
    /// 48 px
    case twenty = 48
    /// 60 px
    case twentyFive = 60

    public var scaledSize: CGFloat {
        UIFontMetrics.default.scaledValue(for: rawValue)
    }
}
