class FileNamingsController < ApplicationController
	def show
    @file_naming = FileNaming.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @file_naming }
    end
  end

  def new
    @file_naming = FileNaming.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @file_naming }
    end
  end

  def edit
    @file_naming = FileNaming.find(params[:id])
  end

  def create
    @file_naming = FileNaming.new(params[:file_naming])

    respond_to do |format|
      if @file_naming.save
        format.html { redirect_to doc_abbreviations_path, notice: 'FileNaming was successfully created.' }
        format.json { render json: @file_naming, status: :created, location: @file_naming }
      else
        format.html { render action: "new" }
        format.json { render json: @file_naming.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @file_naming = FileNaming.find(params[:id])

    respond_to do |format|
      if @file_naming.update_attributes(params[:file_naming])
        format.html { redirect_to doc_abbreviations_path, notice: 'FileNaming was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @file_naming.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @file_naming = FileNaming.find(params[:id])
    @file_naming.destroy

    respond_to do |format|
      format.html { redirect_to @file_naming }
      format.json { head :no_content }
    end
  end
end
