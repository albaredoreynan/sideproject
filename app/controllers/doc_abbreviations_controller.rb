class DocAbbreviationsController < ApplicationController
	helper_method :sort_column, :sort_direction
  def index
    if params[:doc_abbreviation].present?
      @doc_abbreviations = DocAbbreviation.where("name ILIKE ?", "#{params[:doc_abbreviation]}").paginate(:page => params[:page], :per_page => 50).order(sort_column + " " + sort_direction)
    else  
      @doc_abbreviations = DocAbbreviation.paginate(:page => params[:page], :per_page => 50).order("document_name ASC")
    end
    
    @doc_abbreviation_all = DocAbbreviation.order("name ASC")

    @file_naming = FileNaming.find(1)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @doc_abbreviations }
      format.csv { send_data @doc_abbreviations.to_csv }
      format.xls do 
        headers['Content-Disposition'] = "attachment; filename=\"BackupListDocAbbreviations_#{Date.today}.xls\""
      end
      # format.pdf do 
      #   headers['Content-Disposition'] = "attachment; filename=\"#{params[:controller]}\""
      #   render :layout => false
      # end
    end
  end

  def show
    @doc_abbreviation = DocAbbreviation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @doc_abbreviation }
    end
  end

  def new
    @doc_abbreviation = DocAbbreviation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @doc_abbreviation }
    end
  end

  def edit
    @doc_abbreviation = DocAbbreviation.find(params[:id])
  end

  def create
    @doc_abbreviation = DocAbbreviation.new(params[:doc_abbreviation])

    respond_to do |format|
      if @doc_abbreviation.save
        format.html { redirect_to doc_abbreviations_path, notice: 'DocAbbreviation was successfully created.' }
        format.json { render json: @doc_abbreviation, status: :created, location: @doc_abbreviation }
      else
        format.html { render action: "new" }
        format.json { render json: @doc_abbreviation.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @doc_abbreviation = DocAbbreviation.find(params[:id])

    respond_to do |format|
      if @doc_abbreviation.update_attributes(params[:doc_abbreviation])
        format.html { redirect_to doc_abbreviations_path, notice: 'DocAbbreviation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @doc_abbreviation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @doc_abbreviation = DocAbbreviation.find(params[:id])
    @doc_abbreviation.destroy

    respond_to do |format|
      format.html { redirect_to @doc_abbreviation }
      format.json { head :no_content }
    end
  end

  private
  
  def sort_column
    DocAbbreviation.column_names.include?(params[:sort]) ? params[:sort] : "document_name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
