class CaseEntryBillingsController < ApplicationController
	def index
   @case_entry_billing = CaseEntryBilling.all
  end

  def show
    @case_entry_billing = CaseEntryBilling.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @case_entry_billing }
    end
  end

  def new
    @case_entry_billing = CaseEntryBilling.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @case_entry_billing }
    end
  end

  def edit
    @case_entry_billing = CaseEntryBilling.find(params[:id])
  end

  def create
    @case_entry_billing = CaseEntryBilling.new(params[:case_entry_billing])

    respond_to do |format|
      if @case_entry_billing.save
        format.html { redirect_to case_entry_billings_path, notice: 'Case Entry Billing entry was successfully created.' }
        format.json { render json: case_entry_billings_path, status: :created, location: @case_entry_billing }
      else
        format.html { render action: "new" }
        format.json { render json: @case_entry_billing.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @case_entry_billing = CaseEntryBilling.find(params[:id])

    respond_to do |format|
      if @case_entry_billing.update_attributes(params[:case_entry_billing])
        format.html { redirect_to case_entry_billings_path, notice: 'CaseEntryBilling entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @case_entry_billing.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @case_entry_billing = CaseEntryBilling.find(params[:id])
    @case_entry_billing.destroy

    respond_to do |format|
      format.html { redirect_to @case_entry_billing }
      format.json { head :no_content }
    end
  end
end
