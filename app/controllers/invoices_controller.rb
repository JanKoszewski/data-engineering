require 'csv'

class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
    @invoice = Invoice.new
  end

  def show
    @invoice = Invoice.where(id: params[:id]).first
  end

  def create
    raise CSV.parse(params["upload"].read).inspect

  end
end
