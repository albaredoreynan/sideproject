class LawyersController < ApplicationController
  def index
    @lawyers = Lawyer.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lawyers }
      format.csv  { render :csv => @lawyers, :except => [:id] }
      # format.pdf do 
      #   headers['Content-Disposition'] = "attachment; filename=\"#{params[:controller]}\""
      #   render :layout => false
      # end
    end
  end

  def show
    @lawyer = Lawyer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lawyer }
    end
  end

  def new
    @lawyer = Lawyer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lawyer }
    end
  end

  def edit
    @lawyer = Lawyer.find(params[:id])
  end

  def create
    @lawyer = Lawyer.new(params[:lawyer])

    respond_to do |format|
      if @lawyer.save
        format.html { redirect_to @lawyer, notice: 'Lawyer was successfully created.' }
        format.json { render json: @lawyer, status: :created, location: @lawyer }
      else
        format.html { render action: "new" }
        format.json { render json: @lawyer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @lawyer = Lawyer.find(params[:id])

    respond_to do |format|
      if @lawyer.update_attributes(params[:lawyer])
        format.html { redirect_to @lawyer, notice: 'Lawyer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lawyer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @lawyer = Lawyer.find(params[:id])
    @lawyer.destroy

    respond_to do |format|
      format.html { redirect_to @lawyer }
      format.json { head :no_content }
    end
  end
end
