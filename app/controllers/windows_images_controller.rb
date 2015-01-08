class WindowsImagesController < ApplicationController
  before_action :set_windows_image, only: [:show, :edit, :update, :destroy]

  # GET /windows_images
  # GET /windows_images.json
  def index
    @windows_images = WindowsImage.all
  end

  # GET /windows_images/1
  # GET /windows_images/1.json
  def show
  end

  # GET /windows_images/new
  def new
    @windows_image = WindowsImage.new
    @binaries = []
  end

  # GET /windows_images/1/edit
  def edit
  end

  # POST /windows_images
  # POST /windows_images.json
  def create
    @windows_image = WindowsImage.new(name: params[:name])

    params[:binaries].each do |binary|
      @windows_image.binaries << Binary.new(name: binary.name, path: binary.path)
    end
    begin
      # !TODO: generate ISO
    rescue
    end
    respond_to do |format|
      if @windows_image.save
        format.html { redirect_to @windows_image, notice: 'Windows image was successfully created.' }
        format.json { render :show, status: :created, location: @windows_image }
      else
        format.html { render :new }
        format.json { render json: @windows_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /windows_images/1
  # PATCH/PUT /windows_images/1.json
  def update
    respond_to do |format|
      if @windows_image.update(windows_image_params)
        format.html { redirect_to @windows_image, notice: 'Windows image was successfully updated.' }
        format.json { render :show, status: :ok, location: @windows_image }
      else
        format.html { render :edit }
        format.json { render json: @windows_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /windows_images/1
  # DELETE /windows_images/1.json
  def destroy
    @windows_image.destroy
    respond_to do |format|
      format.html { redirect_to windows_images_url, notice: 'Windows image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_windows_image
      @windows_image = WindowsImage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def windows_image_params
      params.require(:windows_image).permit(:name, :binaries)
    end
end
