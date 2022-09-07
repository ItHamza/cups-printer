# frozen_string_literal: true

# Printers Name
class PrintersController < ApplicationController
  require 'cupsffi'
  def index
    printers = CupsPrinter.get_all_printer_names
    render json: printers
  end

  def print
    name = params[:printer]
    file = params[:file]
    return false if name.blank? || file.blank?

    printer = CupsPrinter.new(name)
    path = Rails.root.join(file.path)
    printer.print_file(path.to_s, { 'PageSize' => 'A6' })
  end
end
