class CaseEntriesController < ApplicationController
  helper_method :sort_column, :sort_direction

  autocomplete :file_matter, :file_code, :full => true
  autocomplete :file_matter, :case_number, :full => true

  def index
    if current_user.role == 'Administrator' || current_user.role == 'Billing Clerk'
      # @case_entries = CaseEntry.find(:all, :order => "entry_date DESC")
      if params[:beginning_date].present? && params[:ending_date].present? || params[:file_matter_id] || params[:client_code] || params[:case_title]
        args = {}
        args.merge!(file_matter_id: params[:file_matter_id]) unless params[:file_matter_id].blank?
        args.merge!(case_title: params[:case_title]) unless params[:case_title].blank?
        args.merge!(entry_date: params[:beginning_date]..params[:ending_date]) unless params[:beginning_date].blank?
        args.merge!(client_code: params[:client_code]) unless params[:client_code].blank?
        args.merge!(lawyer_id: current_user.lawyer_id) unless current_user.lawyer_id.blank?
        @case_entries = CaseEntry.where(args).paginate(:page => params[:page], :per_page => 20).order(sort_column + " " + sort_direction)
      else
        @case_entries = CaseEntry.paginate(:page => params[:page], :per_page => 20).order(sort_column + " " + sort_direction)
      end
    else
      if params[:beginning_date].present? && params[:ending_date].present? || params[:file_matter_id] || params[:client_code] || params[:case_title]
        args = {}
        args.merge!(file_matter_id: params[:file_matter_id]) unless params[:file_matter_id].blank?
        args.merge!(case_title: params[:case_title]) unless params[:case_title].blank?
        args.merge!(entry_date: params[:beginning_date]..params[:ending_date]) unless params[:beginning_date].blank?
        args.merge!(client_code: params[:client_code]) unless params[:client_code].blank?
        args.merge!(lawyer_id: current_user.lawyer_id) unless current_user.lawyer_id.blank?
        @case_entries = CaseEntry.where(args).paginate(:page => params[:page], :per_page => 20).order(sort_column + " " + sort_direction)
      else
        # @case_entries = CaseEntry.find(:all, :conditions => { :lawyer_id => current_user.lawyer_id }, :order => "entry_date DESC" ).paginate(:page => params[:page], :per_page => 10)
        @case_entries = CaseEntry.where(:lawyer_id => current_user.lawyer_id).paginate(:page => params[:page], :per_page => 20).order(sort_column + " " + sort_direction)
      end
    end
    @clients = Client.order('cl_code_txt ASC').map{|a|[a.cl_code_txt, a.cl_code_txt]}
    @all_case_entries = CaseEntry.order("entry_date DESC")
    @lawyer = current_user.name
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @case_entries }
      # format.csv  { render :csv => @case_entries, :except => [:id] }
      format.xls do 
        headers['Content-Disposition'] = "attachment; filename=\"BackupCaseEntries_#{Date.today}.xls\""
      end
      format.pdf do 
        pdf = CaseEntriesPdf.new(@case_entries, @lawyer)
        send_data pdf.render, filename: "Case Entry " + Date.today.to_s + ".pdf", disposition: "inline"
      end
    end
  end

  # GET /case_entries/1
  # GET /case_entries/1.json
  def show
    @case_entry = CaseEntry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @case_entry }
    end
  end

  # GET /case_entries/new
  # GET /case_entries/new.json
  def new
    if params[:last_id].present? || !params[:last_id].nil?
      @case_entry = CaseEntry.find(params[:last_id])
    else  
      @case_entry = CaseEntry.new
    end
    @file_matters = FileMatter.find(:all, :group => "file_code, id")
    @file_matter_case = FileMatter.find(:all, :group => "case_number, id")
    @lawyers = Lawyer.all
    @clients = Client.all
    @practicetables = PracticeTable.all
    lawyer = @case_entry.build_lawyer

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @case_entry }
    end
  end

  # GET /case_entries/1/edit
  def edit
    @case_entry = CaseEntry.find(params[:id])
    @file_matters = FileMatter.all
    @lawyers = Lawyer.find(:all, :conditions => { :id => @case_entry.lawyer_id } )
    @clients = Client.all
  end


  def create
    if params[:case_entry][:create_multiple_lawyer_entries] == "1"

      @assigned_lawyers = AssignedLawyer.find(:all, :conditions => { :file_matter_id => params[:filematter_id] } )

        @assigned_lawyers.each do |al|

          @users = User.find(:all, :conditions => {:lawyer_id => al.lawyer_id }  )
          @users.each do |usr|
            @case_entry = CaseEntry.new(
              :file_matter_id => params[:case_entry][:file_matter_id],
              :entry_date => params[:case_entry][:entry_date],
              :time_spent_from => params[:case_entry][:time_spent_from],
              :time_spent_to => params[:case_entry][:time_spent_to],
              :work_particulars => params[:case_entry][:work_particulars],
              :client_id => params[:case_entry][:client_id],
              :case_title => params[:case_entry][:case_title],
              :file_matter_case => params[:case_entry][:file_matter_case],
              :lawyer_id => al.lawyer_id,
              :client_code => params[:case_entry][:client_code],
              :practice_code => params[:case_entry][:practice_code],
              :create_multiple_lawyer_entries => params[:case_entry][:create_multiple_lawyer_entries],
              :user_id => usr.id
            )
            @case_entry.save
          end

        end
        respond_to do |format|
          if params[:commit] == 'Submit & Add New Entry'
            format.html { redirect_to new_case_entry_path, notice: "Entries for Case #{params[:case_entry][:case_title]} has been created." }
          else
            format.html { redirect_to case_entries_path(), notice: 'Case entry was successfully created.' }
            format.json { render json: @case_entry, status: :created, location: @case_entry }
          end
          # format.html { redirect_to case_entries_path(), notice: 'Case entries was successfully created.' }
          # format.json { render json: @case_entry, status: :created, location: @case_entry }
        end

    else
      
      if params[:case_entry_lawyer_id].present?
        @assigned_lawyers = AssignedLawyer.find(:all, :conditions => { :file_matter_id => params[:filematter_id] } )
        @assigned_lawyers.each do |al|

          if params[:case_entry_lawyer_id]["#{al.lawyer_id}"].present?
            @users = User.find(:all, :conditions => {:lawyer_id => al.lawyer_id }  )
            @users.each do |usr|
              @case_entry = CaseEntry.new(
                :file_matter_id => params[:case_entry][:file_matter_id],
                :entry_date => params[:case_entry][:entry_date],
                :time_spent_from => params[:case_entry][:time_spent_from],
                :time_spent_to => params[:case_entry][:time_spent_to],
                :work_particulars => params[:case_entry][:work_particulars],
                :client_id => params[:case_entry][:client_id],
                :case_title => params[:case_entry][:case_title],
                :file_matter_case => params[:case_entry][:file_matter_case],
                :lawyer_id => al.lawyer_id,
                :client_code => params[:case_entry][:client_code],
                :practice_code => params[:case_entry][:practice_code],
                :create_multiple_lawyer_entries => params[:case_entry][:create_multiple_lawyer_entries],
                :user_id => usr.id
              )
              @case_entry.save
            end
          else
            if current_user.lawyer_id == al.lawyer_id
                @case_entry = CaseEntry.new(
                  :file_matter_id => params[:case_entry][:file_matter_id],
                  :entry_date => params[:case_entry][:entry_date],
                  :time_spent_from => params[:case_entry][:time_spent_from],
                  :time_spent_to => params[:case_entry][:time_spent_to],
                  :work_particulars => params[:case_entry][:work_particulars],
                  :client_id => params[:case_entry][:client_id],
                  :case_title => params[:case_entry][:case_title],
                  :file_matter_case => params[:case_entry][:file_matter_case],
                  :lawyer_id => current_user.lawyer_id,
                  :client_code => params[:case_entry][:client_code],
                  :practice_code => params[:case_entry][:practice_code],
                  :create_multiple_lawyer_entries => params[:case_entry][:create_multiple_lawyer_entries],
                  :user_id => current_user.id
                )
                @case_entry.save
            end
          end
        end
      else
        @case_entry = CaseEntry.new(
         :file_matter_id => params[:case_entry][:file_matter_id],
          :entry_date => params[:case_entry][:entry_date],
          :time_spent_from => params[:case_entry][:time_spent_from],
          :time_spent_to => params[:case_entry][:time_spent_to],
          :work_particulars => params[:case_entry][:work_particulars],
          :client_id => params[:case_entry][:client_id],
          :case_title => params[:case_entry][:case_title],
          :file_matter_case => params[:case_entry][:file_matter_case],
          :lawyer_id => current_user.lawyer_id,
          :client_code => params[:case_entry][:client_code],
          :practice_code => params[:case_entry][:practice_code],
          :create_multiple_lawyer_entries => params[:case_entry][:create_multiple_lawyer_entries],
          :user_id => current_user.id
        )
        @case_entry.save
        
      end


      respond_to do |format|
        # format.html { redirect_to case_entries_path(), notice: 'Case entries was successfully created.' }
        # format.json { render json: @case_entry, status: :created, location: @case_entry }
        if params[:commit] == 'Submit & Add New Entry'
          format.html { redirect_to new_case_entry_path(:last_id => @case_entry), notice: "Entries for Case #{params[:case_entry][:case_title]} has been created." }
        else
          format.html { redirect_to case_entries_path(), notice: 'Case entry was successfully created.' }
          format.json { render json: @case_entry, status: :created, location: @case_entry }
        end
      end

    end



  end

  # PUT /case_entries/1
  # PUT /case_entries/1.json
  def update
    @case_entry = CaseEntry.find(params[:id])

    if params[:commit] == 'Submit & Add New Entry'
      if params[:case_entry_lawyer_id].present?
        @assigned_lawyers = AssignedLawyer.find(:all, :conditions => { :file_matter_id => params[:filematter_id] } )
        @assigned_lawyers.each do |al|

          if params[:case_entry_lawyer_id]["#{al.lawyer_id}"].present?
            @users = User.find(:all, :conditions => {:lawyer_id => al.lawyer_id }  )
            @users.each do |usr|
              @case_entry = CaseEntry.new(
                :file_matter_id => params[:case_entry][:file_matter_id],
                :entry_date => params[:case_entry][:entry_date],
                :time_spent_from => params[:case_entry][:time_spent_from],
                :time_spent_to => params[:case_entry][:time_spent_to],
                :work_particulars => params[:case_entry][:work_particulars],
                :client_id => params[:case_entry][:client_id],
                :case_title => params[:case_entry][:case_title],
                :file_matter_case => params[:case_entry][:file_matter_case],
                :lawyer_id => al.lawyer_id,
                :client_code => params[:case_entry][:client_code],
                :practice_code => params[:case_entry][:practice_code],
                :create_multiple_lawyer_entries => params[:case_entry][:create_multiple_lawyer_entries],
                :user_id => usr.id
              )
              @case_entry.save
            end
          else
            if current_user.lawyer_id == al.lawyer_id
               @case_entry = CaseEntry.new(
                 :file_matter_id => params[:case_entry][:file_matter_id],
                  :entry_date => params[:case_entry][:entry_date],
                  :time_spent_from => params[:case_entry][:time_spent_from],
                  :time_spent_to => params[:case_entry][:time_spent_to],
                  :work_particulars => params[:case_entry][:work_particulars],
                  :client_id => params[:case_entry][:client_id],
                  :case_title => params[:case_entry][:case_title],
                  :file_matter_case => params[:case_entry][:file_matter_case],
                  :lawyer_id => current_user.lawyer_id,
                  :client_code => params[:case_entry][:client_code],
                  :practice_code => params[:case_entry][:practice_code],
                  :create_multiple_lawyer_entries => params[:case_entry][:create_multiple_lawyer_entries],
                  :user_id => current_user.id
                )
                @case_entry.save
            end
          end
        end
      else
        @case_entry = CaseEntry.new(
         :file_matter_id => params[:case_entry][:file_matter_id],
          :entry_date => params[:case_entry][:entry_date],
          :time_spent_from => params[:case_entry][:time_spent_from],
          :time_spent_to => params[:case_entry][:time_spent_to],
          :work_particulars => params[:case_entry][:work_particulars],
          :client_id => params[:case_entry][:client_id],
          :case_title => params[:case_entry][:case_title],
          :file_matter_case => params[:case_entry][:file_matter_case],
          :lawyer_id => current_user.lawyer_id,
          :client_code => params[:case_entry][:client_code],
          :practice_code => params[:case_entry][:practice_code],
          :create_multiple_lawyer_entries => params[:case_entry][:create_multiple_lawyer_entries],
          :user_id => current_user.id
        )
        @case_entry.save      
      end
    else

    end
    
    respond_to do |format|
      if params[:commit] == 'Submit & Add New Entry'
        format.html { redirect_to new_case_entry_path(:last_id => @case_entry), notice: "Entries for Case #{params[:case_entry][:case_title]} has been created." }
      else
        if @case_entry.update_attributes(params[:case_entry])
          format.html { redirect_to case_entries_path, notice: 'Case entry was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @case_entry.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    @case_entry = CaseEntry.find(params[:id])
    @case_entry.destroy

    respond_to do |format|
      format.html { redirect_to request.referrer, alert: 'Case entry has been deleted.' }
      format.json { head :no_content }
    end
  end

  def autocomplete_file_matter_file_code
    render json: FileMatter.select("distinct file_code as value").where("file_code ILIKE ?", "%#{params[:term]}%")
    # render json: AnnualProcurementPlan.select("distinct version as value").where("version ILIKE ?", "%#{params[:term]}%").where(:agency_id => current_user.agency.id)
  end

  def autocomplete_file_matter_case_number
    render json: FileMatter.select("distinct case_number as value").where("case_number ILIKE ?", "%#{params[:term]}%")
    # render json: AnnualProcurementPlan.select("distinct version as value").where("version ILIKE ?", "%#{params[:term]}%").where(:agency_id => current_user.agency.id)
  end

  def exclude_billing
    @ce = CaseEntry.find params[:cei]
    @ce.update_attributes(:remove_from_billing => 'Yes')
    redirect_to search_entry_path(params)
  end

  def modify_case_entry
    @case_entry = CaseEntry.find(params[:id])

    if @case_entry.update_attributes(params[:case_entry])
      #format.html { redirect_to case_entries_search_path(:pfr => params[:pfr], :beginning_date => params[:beginning_date], :ending_date => params[:ending_date], :file_matter_id => params[:file_matter_id], :commit => "Search"), notice: 'Modified content' }
      # format.html {  }
      redirect_to request.referrer, notice: 'Modified content'
      #format.json { head :no_content }
    else
      format.html { render action: "edit" }
      format.json { render json: @file_matter.errors, status: :unprocessable_entity }
    end
  end

  def search_entry
      # args = {}
      # args.merge!(file_matter_id: params[:file_matter_id]) unless params[:file_matter_id].blank?
      # args.merge!(case_number: params[:case_number]) unless params[:case_number].blank?
      # args.merge!(entry_date: params[:beginning_date]..params[:ending_date]) unless params[:beginning_date].blank?
      # @case_listings = CaseEntry.where(args)

      # if !params[:file_matter_id].blank? || !params[:case_number].blank? || !params[:beginning_date].blank? || !params[:ending_date].blank? 
        args2 = {}
        year = params[:file_matter_id].to_s.split("-")[0]
        code = params[:file_matter_id].to_s.split("-")[1]
        #args2.merge!(year: year) unless year.blank?
        args2.merge!(file_code: params[:file_matter_id]) unless params[:file_matter_id].blank?
        args2.merge!(case_number: params[:case_number]) unless params[:case_number].blank?
        #args2.merge!(entry_date: params[:beginning_date]..params[:ending_date]) unless params[:beginning_date].blank?
        
        args = {}
        args.merge!(file_matter_id: params[:file_matter_id]) unless params[:file_matter_id].blank?
        args.merge!(file_matter_case: params[:case_number]) unless params[:case_number].blank?
        args.merge!(entry_date: params[:beginning_date]..params[:ending_date]) unless params[:beginning_date].blank?
        # args.merge!(:remove_from_billing => 'No')
        if params[:file_matter_id].blank? && params[:case_number].blank? && params[:beginning_date].blank? && params[:ending_date].blank?
          @case_listings = nil
        else
          @case_listings = CaseEntry.where(args)
        end
        
        @file_matter_info = FileMatter.where(args2)
        @start_date = params[:beginning_date]
        @end_date = params[:ending_date]
        @file_matter_id = params[:file_matter_id]
        @case_number = params[:case_number]

      # else
      #   @case_listings = CaseEntry.find(:all, :conditions => { :entry_date => Date.today })
      # end
      
      # if params[:edit_ent] == 'Yes'
      #   @ce = CaseEntry.find params[:cei]
      #   @ce.update_attributes(:remove_from_billing => 'Yes')
      # else
      respond_to do |format|
          format.html

          format.pdf do 
            pdf = CaseReportsPdf.new(@case_listings, @file_matter_info, @start_date, @end_date, @file_matter_id, @case_number)
            send_data pdf.render, filename: "Timesheet-"+'['+@file_matter_id+']-['+@start_date+'-'+@end_date+"].pdf", disposition: "inline"
          end

          format.csv { send_data @case_entries.to_csv }
          format.xls
          
      end
      # end
  end


  def search_entry_multi
      
      
        args2 = {}
        year = params[:file_matter_id].to_s.split("-")[0]
        code = params[:file_matter_id].to_s.split("-")[1]
        #args2.merge!(year: year) unless year.blank?
        args2.merge!(file_code: params[:file_matter_id]) unless params[:file_matter_id].nil?
        args2.merge!(case_number: params[:case_number]) unless params[:case_number].nil?
        #args2.merge!(entry_date: params[:beginning_date]..params[:ending_date]) unless params[:beginning_date].blank?
        
        args = {}
        args.merge!(entry_date: params[:beginning_date]..params[:ending_date]) unless params[:beginning_date].blank?
        
        
        if params[:file_matter_id].blank? && params[:case_number].blank? && params[:beginning_date].blank? && params[:ending_date].blank?
          @case_listings = nil
        else
          @case_listings = CaseEntry.select("DISTINCT(case_entries.file_matter_id)").where(args)
          @case_listings2 = CaseEntry.where(args)
        end
        
        @file_matter_info = FileMatter.where(args2)
        @start_date = params[:beginning_date]
        @end_date = params[:ending_date]
        @file_matter_id = params[:file_matter_id]
        @case_number = params[:case_number]

      respond_to do |format|
        format.html

        format.pdf do 
          if @file_matter_id.nil?
            pdf = MultiCaseReportsAllPdf.new(@case_listings2, @file_matter_info, @start_date, @end_date)
            send_data pdf.render, filename: "Case Reports " +@start_date+ "-"+@end_date+".pdf", disposition: "inline"
          else
            pdf = MultiCaseReportsPdf.new(@case_listings, @file_matter_info, @start_date, @end_date, @file_matter_id, @case_number)
            send_data pdf.render, filename: "Case Reports " + @file_matter_id + ".pdf", disposition: "inline"
          end
        end

        format.csv { send_data @case_entries.to_csv }
        format.xls
          
      end
      
  end

  # filtering functions
  def filter_by_workload
    
  end

  def filter_by_client_code
    @clients = Client.order('cl_code_txt ASC').map{|a|[a.cl_code_txt, a.cl_code_txt]}
    @lawyers = Lawyer.all.map{|a|[a.full_name, a.id]}
    @file_references = {}
    if current_user.role == 'Administrator' || current_user.role == 'Billing Clerk'
     

      if params[:date_from].present? && params[:date_to].present? || params[:client_code]
         f = Date.parse(params[:date_from])
         t = Date.parse(params[:date_to])
         dfrom = f.strftime("%m/%d/%y")
         dto = t.strftime("%m/%d/%y")
         args = {}
         args.merge!(cl_code_txt: params[:client_code]) unless params[:client_code].blank?
         # args.merge!(file_matter_id: params[:file_ref]) unless params[:file_ref].blank?
         # args.merge!(case_date: dfrom..dto) unless params[:date_from].blank?
         # args.merge!(lawyer_id: current_user.lawyer_id) unless current_user.lawyer_id.blank?
         @case_entries = FileMatter.where(args).where("TO_DATE(case_date, 'MM/DD/YY')  BETWEEN ? AND ?", params[:date_from], params[:date_to]).where("practice_code <> ''").where("practice_code IS NOT NULL")
         # @file_matters = FileMatter.where(args).where(file_code: @case_entries).pluck(:practice_code)
         # raise
      end   

    else
      # if params[:beginning_date].present? && params[:ending_date].present? || params[:file_matter_id]
      #   args = {}
      #   args.merge!(file_matter_id: params[:file_matter_id]) unless params[:file_matter_id].blank?
      #   args.merge!(case_number: params[:case_number]) unless params[:case_number].blank?
      #   args.merge!(entry_date: params[:beginning_date]..params[:ending_date]) unless params[:beginning_date].blank?
      #   args.merge!(lawyer_id: current_user.lawyer_id) unless current_user.lawyer_id.blank?
      #   @case_entries = CaseEntry.where(args).paginate(:page => params[:page], :per_page => 20).order(sort_column + " " + sort_direction)
      # else
      #   # @case_entries = CaseEntry.find(:all, :conditions => { :lawyer_id => current_user.lawyer_id }, :order => "entry_date DESC" ).paginate(:page => params[:page], :per_page => 10)
      #   @case_entries = CaseEntry.where(:lawyer_id => current_user.lawyer_id).paginate(:page => params[:page], :per_page => 20).order(sort_column + " " + sort_direction)
      # end
    end
    # @all_case_entries = CaseEntry.order("entry_date DESC")
    # @lawyer = current_user.name
    # respond_to do |format|
    #   format.html # index.html.erb
    #   format.json { render json: @case_entries }
    #   # format.csv  { render :csv => @case_entries, :except => [:id] }
    #   format.xls do 
    #     headers['Content-Disposition'] = "attachment; filename=\"BackupCaseEntries_#{Date.today}.xls\""
    #   end
    #   format.pdf do 
    #     pdf = CaseEntriesPdf.new(@case_entries, @lawyer)
    #     send_data pdf.render, filename: "Case Entry " + Date.today.to_s + ".pdf", disposition: "inline"
    #   end
    # end
  end

  def filter_by_practice_code
    # @clients = Client.order('cl_code_txt ASC').map{|a|[a.cl_code_txt, a.cl_code_txt]}
    @practices = PracticeTable.order('practice_name ASC').map{|a|[a.practice_name+'('+a.text_code+')', a.text_code]}
    @lawyers = Lawyer.all.map{|a|[a.full_name, a.id]}
    @file_references = {}
    if current_user.role == 'Administrator' || current_user.role == 'Billing Clerk'
      # # @case_entries = CaseEntry.find(:all, :order => "entry_date DESC")
      if params[:date_from].present? && params[:date_to].present? || params[:practice_code]
         f = Date.parse(params[:date_from])
         t = Date.parse(params[:date_to])
         dfrom = f.strftime("%m/%d/%y")
         dto = t.strftime("%m/%d/%y")
         args = {}
         args.merge!(practice_code: params[:practice_code]) unless params[:practice_code].blank?
         # args.merge!(file_matter_id: params[:file_ref]) unless params[:file_ref].blank?
         # args.merge!(entry_date: params[:date_from]..params[:date_to]) unless params[:date_from].blank?
         # args.merge!(lawyer_id: current_user.lawyer_id) unless current_user.lawyer_id.blank?
         @case_entries = FileMatter.where(args).where("TO_DATE(case_date, 'MM/DD/YY')  BETWEEN ? AND ?", params[:date_from], params[:date_to]).where("practice_code <> ''").where("practice_code IS NOT NULL")
      # else
      #   @case_entries = CaseEntry.paginate(:page => params[:page], :per_page => 20).order(sort_column + " " + sort_direction)
      end
    else
    end
  end

  def filter_by_period
    
  end

  def filter_by_workload
    @lawyers2 = Lawyer.where(is_active: 'Yes').map{|a|[a.full_name, a.id]}
    if current_user.role == 'Administrator' || current_user.role == 'Billing Clerk'
      if params[:beginning_date].present? && params[:ending_date].present? || params[:lawyer_id]
        f = Date.parse(params[:beginning_date])
        t = Date.parse(params[:ending_date])
        dfrom = f.strftime("%m/%d/%y")
        dto = t.strftime("%m/%d/%y")
        @lid = params[:lawyer_id]
        @assigned = AssignedLawyer.where(lawyer_id: @lid).pluck(:file_matter_id)
        @file_ref = FileMatter.where(id: @assigned).pluck(:file_code)

        @case_entries = FileMatter.where("TO_DATE(case_date, 'MM/DD/YY')  BETWEEN ? AND ?", params[:beginning_date], params[:ending_date]).where("practice_code <> ''").where("practice_code IS NOT NULL").where(id: @assigned)
        
      # else
      #   @case_entries = CaseEntry.paginate(:page => params[:page], :per_page => 20).order(sort_column + " " + sort_direction)
      end   
    else
    end
  end

  def filter_by_compared_workload
    @lawyers2 = Lawyer.where(is_active: 'Yes').map{|a|[a.full_name, a.id]}
    if current_user.role == 'Administrator' || current_user.role == 'Billing Clerk'
      if params[:beginning_date].present? && params[:ending_date].present? || params[:lawyer_id]
        f = Date.parse(params[:beginning_date])
        t = Date.parse(params[:ending_date])
        dfrom = f.strftime("%m/%d/%y")
        dto = t.strftime("%m/%d/%y")
        @lid = params[:lawyer_id]
        @assigned = AssignedLawyer.where(lawyer_id: @lid).pluck(:file_matter_id)
        @file_ref = FileMatter.where(id: @assigned).pluck(:file_code)

        @case_entries = FileMatter.where("TO_DATE(case_date, 'MM/DD/YY')  BETWEEN ? AND ?", params[:beginning_date], params[:ending_date]).where("practice_code <> ''").where("practice_code IS NOT NULL").where(id: @assigned)
        
      # else
      #   @case_entries = CaseEntry.paginate(:page => params[:page], :per_page => 20).order(sort_column + " " + sort_direction)
      end   
    else
    end
  end

  private
  
  def sort_column
    CaseEntry.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end
  
  def sort_direction  
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end
