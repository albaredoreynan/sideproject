class PracticeTablesController < ApplicationController
  helper_method :sort_column, :sort_direction
  def index
    if params[:practice_table].present?
      @practice_tables = PracticeTable.where("name ILIKE ?", "#{params[:practice_table]}").paginate(:page => params[:page], :per_page => 50).order(sort_column + " " + sort_direction)
    else  
      @practice_tables = PracticeTable.paginate(:page => params[:page], :per_page => 50).order("practice_name ASC")
    end
    
    @practice_table_all = PracticeTable.order("name ASC")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @practice_tables }
      format.csv { send_data @practice_tables.to_csv }
      format.xls do 
        headers['Content-Disposition'] = "attachment; filename=\"BackupListPracticeTables_#{Date.today}.xls\""
      end
      # format.pdf do 
      #   headers['Content-Disposition'] = "attachment; filename=\"#{params[:controller]}\""
      #   render :layout => false
      # end
    end
  end

  def show
    @practice_table = PracticeTable.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @practice_table }
    end
  end

  def new
    @practice_table = PracticeTable.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @practice_table }
    end
  end

  def edit
    @practice_table = PracticeTable.find(params[:id])
  end

  def create
    @practice_table = PracticeTable.new(params[:practice_table])

    respond_to do |format|
      if @practice_table.save
        format.html { redirect_to practice_tables_path, notice: 'PracticeTable was successfully created.' }
        format.json { render json: @practice_table, status: :created, location: @practice_table }
      else
        format.html { render action: "new" }
        format.json { render json: @practice_table.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @practice_table = PracticeTable.find(params[:id])

    respond_to do |format|
      if @practice_table.update_attributes(params[:practice_table])
        format.html { redirect_to practice_tables_path, notice: 'PracticeTable was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @practice_table.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @practice_table = PracticeTable.find(params[:id])
    @practice_table.destroy

    respond_to do |format|
      format.html { redirect_to @practice_table }
      format.json { head :no_content }
    end
  end

  private
  
  def sort_column
    PracticeTable.column_names.include?(params[:sort]) ? params[:sort] : "practice_name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

end
