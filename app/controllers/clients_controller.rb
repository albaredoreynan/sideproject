class ClientsController < ApplicationController
  def index
    if params[:client].present?
      @clients = Client.where("name ILIKE ?", "#{params[:client]}").paginate(:page => params[:page], :per_page => 50, :order => "name ASC")
    else  
      @clients = Client.paginate(:page => params[:page], :per_page => 50, :order => "name ASC")
    end
    @client_all = Client.order("name ASC")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clients }
      format.csv { send_data @clients.to_csv }
      format.xls do 
        headers['Content-Disposition'] = "attachment; filename=\"BackupListClients_#{Date.today}.xls\""
      end
      # format.pdf do 
      #   headers['Content-Disposition'] = "attachment; filename=\"#{params[:controller]}\""
      #   render :layout => false
      # end
    end
  end

  def show
    @client = Client.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @client }
    end
  end

  def new
    @client = Client.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @client }
    end
  end

  def edit
    @client = Client.find(params[:id])
  end

  def create
    @client = Client.new(params[:client])

    respond_to do |format|
      if @client.save
        format.html { redirect_to clients_path, notice: 'Client was successfully created.' }
        format.json { render json: @client, status: :created, location: @client }
      else
        format.html { render action: "new" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @client = Client.find(params[:id])

    respond_to do |format|
      if @client.update_attributes(params[:client])
        format.html { redirect_to clients_path, notice: 'Client was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy

    respond_to do |format|
      format.html { redirect_to @client }
      format.json { head :no_content }
    end
  end
end
