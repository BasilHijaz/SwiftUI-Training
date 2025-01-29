//
//  Localization.swift
//  TableViewDemoExcersise
//
//  Created by Basil Hijaz on 19/01/2025.
//

import Cocoa

enum LocalizationKey: String, LocalizationKeyEnumProtocol {

    // MARK: - App Description
    case personTableAppName = "person_table.storyboard_name"
    case appDescriptionPopoverTitleText = "person_table_app.app_description_popover.title.text"
    case appDescriptionPopoverMessageText = "person_table_app.app_description_popover.message.text"
    case filterPlaceholderText = "person_table_app.filter_placeholder.text"
    case selectedItemDescriptionLabelText = "person_table_app.selected_item_description_label.text"

    // MARK: - Identifiers
    case addPersonViewControllerIdentifierText = "person_table_app.add_person_view_controller.identifier.text"
    case appDescriptionPopoverViewControllerIdentifierText =
            "person_table_app.app_description_popover_view_controller.identifier.text"

    // MARK: - Errors
    case unableToDisplayAddPersonViewController = "person_table_error.unable_to_display_add_person.error_description.text"
    case emptyFieldsInAddPersonAlertTitle = "person_table_alert.empty_field_message_title.text"
    case emptyFieldsInAddPersonAlertDescription = "person_table_alert.empty_field_message.description.text"
    case nameShouldBeUniqueInAddPersonAlertTitle = "person_table_alert.name_should_be_unique_message_title.text"
    case nameShouldBeUniqueInAddPersonAlertDescription =
            "person_table_alert.name_should_be_unique_message.description.text"
    case alertConfirmationButtonText = "person_table_alert.confirmation_button.text"

    // MARK: - Add Person
    case addPersonLoadingStateIsInProgress = "add_person_loading_progress_view.add_person_loading_status.in_progress"
    case addPersonNameTextFieldPlaceholder = "person_table_app.add_person.name_text_field.placeholder.text"
    case addPersonButtonTitleText = "person_table_app.add_person.button.title.text"
    case addPersonViewBackButtonTitleText = "person_table_app.add_person_back_button.title.text"

    // MARK: - Enums Options
    case descriptionImageStarOption = "person_table.description_image_options.star.text"
    case descriptionImagePcOption = "person_table.description_image_options.pc.text"
    case tableMenuDeleteOption = "person_table.table_menu_options.delete.text"
    case tableColumnNameTitle = "person_table.table_view_columns.name.text"
    case tableColumnIdentifierTitle = "person_table.table_view_columns.identifier.text"
    case tableColumnDescriptionImageTitle = "person_table.table_view_columns.description_image.text"
}
