# frozen_string_literal: true

# post available printers by api
class SetPrinterJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    printers = CupsPrinter.get_all_printer_names

    data = { 'printers[]': printers }
    url = "https://gettabox.channeldispatch.co.uk//api/v1/available_printers?#{URI.encode_www_form(data)}"

    HTTParty.get(url)
    # self.class.set(wait: 300.seconds).perform_later(printer_label_ids: id) unless response.success?
  end
end
