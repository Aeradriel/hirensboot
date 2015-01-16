class WindowsImagesController < ApplicationController
  before_action :set_windows_image, only: [:show, :edit, :update, :destroy, :download_image]

  # GET /windows_images
  # GET /windows_images.json
  def index
    @windows_images = WindowsImage.where(user: current_user)
  end

  # GET /windows_images/1
  # GET /windows_images/1.json
  def show
  end

  # GET /windows_images/new
  def new
    @windows_image = WindowsImage.new
    @binaries = {}
    Binary.all.each do |binary|
      @binaries[binary.name.to_sym] = binary.id
    end
  end

  def download_image
    if @windows_image.user.id == current_user.id
      send_file @windows_image.path
    else
      redirect_to unauthenticated_root_path
    end
  end

  # GET /windows_images/1/edit
  def edit
    @binaries = {}
    Binary.all.each do |binary|
      @binaries[binary.name.to_sym] = binary.id
    end
  end

  # POST /windows_images
  # POST /windows_images.json
  def create
    @windows_image = WindowsImage.new(windows_image_params)

    cmd = [
        "CALL copype x86 C:\\WinPE_x86",
        "CALL Dism /Mount-Image /ImageFile:\"C:\\WinPE_x86\\media\\sources\\boot.wim\" /index:1 /MountDir:\"C:\\WinPE_x86\\mount\""
    ]
    @windows_image.path = "#{ISO_DIRECTORY_PATH}/WinPE_#{Time.now.to_i}.iso"
    @windows_image.user = current_user
    thread = Thread.new do
      @windows_image.binaries.each do |binary|
        cmd << "CALL md \"C:\\WinPE_x86\\mount\\windows\\#{binary.name}\""
        cmd << "CALL Xcopy C:\\#{binary.name} \"C:\\WinPE_amd64\\mount\\windows\\#{binary.name}\""
      end
      cmd << "CALL Dism /Unmount-Image /MountDir:\"C:\\WinPE_x86\\mount\" /commit"
      cmd << "CALL MakeWinPEMedia /ISO C:\\WinPE_x86 #{@windows_image.path}"
      cmd << 'exit'
      batch_path = Rails.public_path + ADK_BAT_FILE_NAME
      script_path = "#{Rails.public_path}/#{Time.now.to_i}#{ADK_BAT_FILE_NAME}"
      FileUtils.cp batch_path, script_path
      begin
        system("echo. >> #{script_path}")
        cmd.each do |cmd_i|
          system("echo #{cmd_i} >> #{script_path}")
        end
        system("C:\\WINDOWS\\system32\\cmd.exe /k #{script_path}")
      rescue Exception => e
        render text: e.to_s
      end
      FileUtils.rm(script_path)
    end
    thread.join
    if @windows_image.save
      flash[:info] = "L'image a bien ete cree"
    else
      flash[:error] = "Erreur pendant la creation de l'image"
    end
    redirect_to windows_images_url
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
    @windows_image = WindowsImage.find(params[:id]) if params[:id]
    @windows_image ||= WindowsImage.find(params[:windows_image_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def windows_image_params
    params.require(:windows_image).permit(:name, :binaries)
  end
end
