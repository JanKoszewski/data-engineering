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
    if params["invoice"] && Invoice.create_and_store(params["invoice"])
      redirect_to index
    else
      flash[:error] = "Incorrect filetype, please used tab delimited records"
      redirect_to index
    end
  end
end
