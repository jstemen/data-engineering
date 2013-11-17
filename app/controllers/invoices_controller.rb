class InvoicesController < ApplicationController
  def new

  end

  def index
     @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def edit
    @invoice = Invoice.find(params[:id])
  end

  def destroy
    Invoice.delete(params[:id])
    redirect_to :action => 'index'
  end

  def update
    @invoice = Invoice.find(params[:id])
    if @invoice.update_attributes(params[:invoice])
      redirect_to :action => 'show', :id => @invoice
    else
      flash[:alert] = 'Edit failed!'
      render :action => 'edit'
    end
  end

  def import
    total_gross_revenue = Invoice.import(params[:file].path)
    flash[:notice] = "The total gross revenue of the file uploaded was $#{total_gross_revenue}"
    redirect_to :action => 'index'
  end


end
