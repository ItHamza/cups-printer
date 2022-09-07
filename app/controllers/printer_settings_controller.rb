# frozen_string_literal: true

require 'rails/application_controller'

# Printers Name
class PrinterSettingsController < Rails::ApplicationController
  def index
    @printers = CupsPrinter.get_all_printer_names
    render file: Rails.root.join('app/views/layouts/printer_settings/index.html.erb')
  end
end
