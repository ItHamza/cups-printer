# frozen_string_literal: true

# amazon feed response status
class PrinterJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    data = {
      user_id: 7
    }
    url = "https://gettabox.channeldispatch.co.uk//api/v1/download_file?#{URI.encode_www_form(data)}"
    response = HTTParty.get(url)
    return 'Files not found' unless response.success? && response['files'].present?

    save_response(response['files'], response['printer_name'])
  end

  def save_response(files, printer_name)
    printer_label_ids = []
    files.each do |file|
      path = Rails.root.join('public', file.second.to_s)
      File.open(path.to_s, 'wb') do |f|
        f.write(Base64.decode64(file.first))
      end
      print_file(path, printer_name)
      printer_label_ids << file.last
    end
    UpdatePrinterLabelJob.perform_now(printer_label_ids: printer_label_ids)
  end

  def print_file(path, printer_name)
    # printers = CupsPrinter.get_all_printer_names
    printer = CupsPrinter.new(printer_name)
    printer.print_file(path.to_s, { 'PageSize' => 'A6' })
  end
end
