# frozen_string_literal: true

# update printer label table with ids
class UpdatePrinterLabelJob < ApplicationJob
  queue_as :default

  def perform(*args)
    ids = args.first[:printer_label_ids] || args.first['printer_label_ids']

    data = { printer_label_ids: ids }
    url = "http://localhost:3000/api/v1/update_printers?#{URI.encode_www_form(data)}"

    response = HTTParty.post(url)
    self.class.set(wait: 300.seconds).perform_later(printer_label_ids: id) unless response.success?
  end
end
