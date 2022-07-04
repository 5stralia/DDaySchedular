//
//  ComplicationController.swift
//  DDay WatchKit Extension
//
//  Created by Hoju Choi on 2022/07/04.
//

import ClockKit

class ComplicationController: NSObject, CLKComplicationDataSource {

    // MARK: - Complication Configuration

    func getComplicationDescriptors(handler: @escaping ([CLKComplicationDescriptor]) -> Void) {
        let descriptors = [
            CLKComplicationDescriptor(identifier: "complication", displayName: "DDay", supportedFamilies: [.circularSmall, .graphicCircular])
            // Multiple complication support can be added here with more descriptors
        ]

        // Call the handler with the currently supported complication descriptors
        handler(descriptors)
    }

    func handleSharedComplicationDescriptors(_ complicationDescriptors: [CLKComplicationDescriptor]) {
        // Do any necessary work to support these newly shared complication descriptors
    }

    // MARK: - Timeline Configuration

    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        // Call the handler with the last entry date you can currently provide or nil if you can't support future timelines
        handler(nil)
    }

    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        // Call the handler with your desired behavior when the device is locked
        handler(.showOnLockScreen)
    }

    // MARK: - Timeline Population

    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        if let template = complicationTemplate(for: complication) {
            let entry = CLKComplicationTimelineEntry(
                date: Date(),
                complicationTemplate: template)
            handler(entry)
        } else {
            handler(nil)
        }
    }

    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after the given date
        handler(nil)
    }

    // MARK: - Sample Templates

    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        let template = complicationTemplate(for: complication)
        handler(template)
    }

    private func complicationTemplate(for complication: CLKComplication) -> CLKComplicationTemplate? {
        switch complication.family {
        case .circularSmall:
            return CLKComplicationTemplateCircularSmallRingText(
                textProvider: CLKSimpleTextProvider(text: "test"),
                fillFraction: 0.3,
                ringStyle: .closed)
        case .graphicCircular:
            return CLKComplicationTemplateGraphicCircularImage(
                imageProvider: CLKFullColorImageProvider(
                    fullColorImage: UIImage(systemName: "calendar")!
                )
            )
        default:
            return nil
        }
    }
}
