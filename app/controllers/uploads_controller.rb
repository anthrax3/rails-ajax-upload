class UploadsController < ApplicationController
  before_action :set_upload, only: [:show, :edit, :update, :destroy]

  # GET /uploads
  # GET /uploads.json
  def index
    @uploads = Upload.all
    @upload = Upload.new
  end

  # GET /uploads/1
  # GET /uploads/1.json
  def show
  end

  # GET /uploads/new
  def new
    @upload = Upload.new
  end

  # GET /uploads/1/edit
  def edit
  end

  # POST /uploads
  # POST /uploads.json
  def create
    if !Dir.exists?(Rails.root.join('public', 'uploads'))
      Dir.mkdir(Rails.root.join('public', 'uploads'))
    end

    data = upload_params
    filename = data[:image].original_filename

    File.open(Rails.root.join('public', 'uploads', filename), 'wb+') do | f |
      f.write data[:image].read
      f.close
    end

    data[:image] = filename
    @upload = Upload.new(data)

    respond_to do |format|
      if @upload.save
        format.html { redirect_to @upload, notice: 'Upload was successfully created.' }
        format.json { render action: 'show', status: :created, location: @upload }
        format.js { @uploads = Upload.all }
      else
        format.html { render action: 'new' }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /uploads/1
  # PATCH/PUT /uploads/1.json
  def update
    respond_to do |format|
      if @upload.update(upload_params)
        format.html { redirect_to @upload, notice: 'Upload was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /uploads/1
  # DELETE /uploads/1.json
  def destroy
    @upload.destroy
    respond_to do |format|
      format.html { redirect_to uploads_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_upload
      @upload = Upload.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def upload_params
      params.require(:upload).permit(:image)
    end
end
