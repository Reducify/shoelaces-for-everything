class SomethingsController < ApplicationController
  # GET /somethings
  # GET /somethings.xml
  def index
    @somethings = Something.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @somethings }
    end
  end

  # GET /somethings/1
  # GET /somethings/1.xml
  def show
    @something = Something.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @something }
    end
  end

  # GET /somethings/new
  # GET /somethings/new.xml
  def new
    @something = Something.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @something }
    end
  end

  # GET /somethings/1/edit
  def edit
    @something = Something.find(params[:id])
    
    # redirect if you're trying to edit someone else's work
    if @something.ip_address != request.remote_ip
      redirect_to(somethings_url)
    end
  end

  # POST /somethings
  # POST /somethings.xml
  def create
    @something = Something.new(params[:something])
    @something.ip_address = request.remote_ip
    @something.something = params[:something][:something]
    respond_to do |format|
      if @something.save
        format.html { redirect_to(@something, :notice => 'Your shoelace was successfully created.') }
        format.xml  { render :xml => @something, :status => :created, :location => @something }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @something.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /somethings/1
  # PUT /somethings/1.xml
  def update
    @something = Something.find(params[:id])

    respond_to do |format|
      if @something.update_attributes(params[:something])
        format.html { redirect_to(@something, :notice => 'Your shoelace was updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @something.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /somethings/1
  # DELETE /somethings/1.xml
  def destroy
    @something = Something.find(params[:id])
    @something.destroy

    # respond_to do |format|
      # format.html { redirect_to(somethings_url) }
      # format.xml  { head :ok }
    # end
    redirect_to '/somethings'
  end
end