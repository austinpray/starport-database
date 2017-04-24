class SvgImagesController < ApplicationController
  before_action :set_svg_image, only: [:show, :edit, :update, :destroy]

  before_filter :restrict_access_to_admins, except: [:index, :show]

  # GET /svg_images
  # GET /svg_images.json
  def index
    @svg_images = SvgImage.all
  end

  # GET /svg_images/1.svg
  def show
    permit = params.permit(:color)
    respond_to do |format|
      format.svg do
        if permit[:color]
          begin
            color = permit[:color].paint.to_hex
          rescue Chroma::Errors::UnrecognizedColor
            return render plain: '?color needs to be a valid color', status: :bad_request
          end

          return render inline: @svg_image.colorize(color)
        end
        render inline: @svg_image.sanitized_data
      end
      format.html
      format.json
    end
  end

  # GET /svg_images/new
  def new
    @svg_image = SvgImage.new
  end

  # GET /svg_images/1/edit
  def edit
  end

  # POST /svg_images
  # POST /svg_images.json
  def create
    @svg_image = SvgImage.new(svg_image_params)

    respond_to do |format|
      if @svg_image.save
        format.html { redirect_to @svg_image, notice: 'Svg image was successfully created.' }
        format.json { render :show, status: :created, location: @svg_image }
      else
        format.html { render :new }
        format.json { render json: @svg_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /svg_images/1
  # PATCH/PUT /svg_images/1.json
  def update
    respond_to do |format|
      if @svg_image.update(svg_image_params)
        format.html { redirect_to @svg_image, notice: 'Svg image was successfully updated.' }
        format.json { render :show, status: :ok, location: @svg_image }
      else
        format.html { render :edit }
        format.json { render json: @svg_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /svg_images/1
  # DELETE /svg_images/1.json
  def destroy
    @svg_image.destroy
    respond_to do |format|
      format.html { redirect_to svg_images_url, notice: 'Svg image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_svg_image
      @svg_image = SvgImage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def svg_image_params
      params.require(:svg_image).permit(:data, :name, :source)
    end
end
