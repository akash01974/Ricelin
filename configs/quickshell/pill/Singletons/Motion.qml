pragma Singleton
import QtQuick
import Quickshell

Singleton {
    readonly property real mult: Flags.reduceMotion ? 0.4 : 1
    readonly property int fast:     Math.round(140 * mult)
    readonly property int standard: Math.round(300 * mult)
    readonly property int morph:    Math.round(420 * mult)
    readonly property int shapeshift: Math.round(820 * mult)
    readonly property int glide:    Math.round(260 * mult)
    readonly property int heat:     Math.round(1100 * mult)
    readonly property int easeStandard: Easing.OutCubic
    readonly property int easeMorph:    Easing.BezierSpline

    /**
     * Liquid morph curve, cubic-bezier(0.16, 1, 0.3, 1). Front-loaded like an
     * exponential chase but with a long, visible settle tail. Use with
     * easeMorph (BezierSpline).
     */
    readonly property var morphCurve: [0.16, 1, 0.3, 1, 1, 1]
    readonly property real rSmall: 7
    readonly property real rTile:  13

    /** Looping scan/pairing breath pulse. */
    readonly property int pulse: Math.round(420 * mult)

    /**
     * Content choreography: fractions of the body morph progress (0..1)
     * that determine when incoming content begins to fade in and outgoing
     * fades out. These are pure fractions — actual durations are derived by
     * reduceMotion mult).
     *
     * NOTE: Ricelin does NOT use progress fractions for content choreography.
     * Content fade is driven directly by morphCloseness (see Pill.qml face opacities).
     * These fractions are kept for optional use but do not affect the core
     * animation feel which is determined by morphCloseness-driven opacity.
     */
    readonly property real contentInAt: 0.1       // morphP threshold to start incoming ramp (optional)
    readonly property real contentInSpan: 0.4     // progress span to fully visible (inAt .. inAt+span) (optional)
    readonly property real contentOutSpan: 0.3    // progress span to fully fade out (0 .. outSpan) (optional)

    /** OSD profile: a fast morph for transient overlays, ~200 ms scaled by mult. */
    readonly property int osd: Math.round(200 * mult)

    /** OSD profile: a fast morph for transient overlays, ~200 ms scaled by mult. */
}
