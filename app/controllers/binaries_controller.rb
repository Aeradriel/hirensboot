class BinariesController < ApplicationController
  before_action :set_binary, only: [:show, :edit, :update,
                                    :destroy, :download]

  # GET /binaries
  # GET /binaries.json
  def index
    @binaries = Binary.all
  end

  # GET /binaries/1
  # GET /binaries/1.json
  def show
  end

  # GET /binaries/new
  def new
    @binary = Binary.new
  end

  # GET /binaries/1/edit
  def edit
  end

  # POST /binaries
  # POST /binaries.json
  def create
    @binary = Binary.new(binary_params)

    begin
      name = params[:binary][:path].original_filename
      path = "#{Rails.public_path}\\binaries\\#{Time.now.to_i}_#{name}"
      path.gsub! '/', '\\'
      File.open(path, 'wb') { |f| f.write(params[:binary][:path].read) }
      @binary.path = path
      flash[:notice] =  'Binary was successfully created' if @binary.save
    rescue Exception => e
      flash[:alert] = "Impossible de sauvegarder le binaire : #{e.to_s}"
    end
    redirect_to binaries_path
  end

  # PATCH/PUT /binaries/1
  # PATCH/PUT /binaries/1.json
  def update
    @binary.assign_attributes(binary_params)
    begin
      name = params[:binary][:path].original_filename + '_' + Time.now.to_s
      path = "#{Rails.public_path}\\binaries\\#{Time.now.to_i}_#{name}"
      path.gsub! '/', '\\'
      File.open(path, 'wb') { |f| f.write(params[:binary][:path].read) }
      @binary.path = path
      flash[:notice] =  'Binary was successfully created' if @binary.save
      rescue
      flash[:alert] = 'Impossible de sauvegarder le binaire'
    end
    redirect_to binaries_path
  end

  # DELETE /binaries/1
  # DELETE /binaries/1.json
  def destroy
    FileUtils.rm_f(@binary.path)
    @binary.destroy
    respond_to do |format|
      format.html { redirect_to binaries_url, notice: 'Binary was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def download
    begin
      send_file @binary.path
    rescue
      flash[:error] = 'Impossible de télécharger le fichier. Celui-ci est a peut-être été supprimé.'
      redirect_to windows_images_path
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_binary
    @binary = Binary.find(params[:id]) if params[:id]
    @binary ||= Binary.find(params[:binary_id])

  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def binary_params
    params.require(:binary).permit(:name, :path)
  end
end
