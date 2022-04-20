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

    args = {}
    args.merge!(file_matter_id: @case_entry_billing.file_reference_code) unless @case_entry_billing.file_reference_code.blank?
    # args.merge!(file_matter_case: params[:case_number]) unless params[:case_number].blank?
    args.merge!(entry_date: @case_entry_billing.cover_period_start..@case_entry_billing.cover_period_end) unless @case_entry_billing.cover_period_start.blank?
    # args.merge!(:remove_from_billing => 'No')
    if @case_entry_billing.file_reference_code.blank? && @case_entry_billing.cover_period_start.blank? && @case_entry_billing.cover_period_end.blank?
      @case_listings = nil
    else
      @case_listings = CaseEntry.where(args)
    end
    @case_listings.update_all(mark_as_billed: false)
    @case_entry_billing.destroy

    respond_to do |format|
      format.html { redirect_to @case_entry_billing }
      format.json { head :no_content }
    end
  end

  def view_billing_generated
    @case_entry_billing = CaseEntryBilling.find(params[:id])
    args = {}
    args.merge!(file_matter_id: @case_entry_billing.file_reference_code) unless @case_entry_billing.file_reference_code.blank?
    # args.merge!(file_matter_case: params[:case_number]) unless params[:case_number].blank?
    args.merge!(entry_date: @case_entry_billing.cover_period_start..@case_entry_billing.cover_period_end) unless @case_entry_billing.cover_period_start.blank?
    # args.merge!(:remove_from_billing => 'No')
    if @case_entry_billing.file_reference_code.blank? && @case_entry_billing.cover_period_start.blank? && @case_entry_billing.cover_period_end.blank?
      @case_listings = nil
    else
      @case_listings = CaseEntry.where(args)
    end

    @file_matter_info = FileMatter.where(file_code: @case_entry_billing.file_reference_code)
    @start_date = @case_entry_billing.cover_period_start
    @end_date = @case_entry_billing.cover_period_end
    @file_matter_id = @case_entry_billing.file_reference_code
    # @case_number = params[:case_number]

    respond_to do |format|
          format.html

          format.pdf do 
            pdf = CaseReportsPdf.new(@case_listings, @file_matter_info, @start_date, @end_date, @file_matter_id, @case_number)
            send_data pdf.render, filename: "Timesheet-"+'['+@file_matter_id+']-['+@start_date+'-'+@end_date+"].pdf", disposition: "inline"
          end

          format.csv { send_data @case_entries.to_csv }
          format.xls
          
      end
  end
end
