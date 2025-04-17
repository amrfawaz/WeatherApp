//
//  Style+Spacing.swift
//  
//
//  Created by Amr Abd-Elhakim on 17/04/2025.
//

import Foundation

public enum Style {}

public extension Style {
    enum Spacing {
        /// 0.0 3xs
        public static let xxxs: Double = 0.0
        /// 4.0 2xs
        public static let xxs: Double = 4.0
        /// 8.0 xs
        public static let xs: Double = 8.0
        /// 12.0 sm
        public static let sm: Double = 12.0
        /// 16.0 md
        public static let md: Double = 16.0
        /// 24.0 lg
        public static let lg: Double = 24.0
        /// 32.0 xl
        public static let xl: Double = 32.0
        /// 40.0 xxl
        public static let xxl: Double = 40.0
        /// 48.0 xxxl
        public static let xxxl: Double = 48.0

        // All the spacings below are used only in the specific situations where we needed to mimic figma
        // but the designs were referencing views in other view hierarchy, or were centering elements
        // on the screen etc.

        /// 64.0
        public static let px64: Double = 64.0
        /// 80.0
        public static let px80: Double = 80.0
        /// 96.0
        public static let px96: Double = 96.0
    }

    enum Size {
        public static let searchButtonHeight: Double = 40
    }
}
