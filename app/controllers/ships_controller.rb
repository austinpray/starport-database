class ShipsController < ApplicationController
  before_action :set_ship, only: [:show, :edit, :update, :destroy]

  before_filter :restrict_access_to_admins, except: [:index, :create, :show]
  # GET /ships
  # GET /ships.json
  def index
    @ships = Ship.all
  end

  # GET /ships/1
  # GET /ships/1.json
  def show
  end

  # GET /ships/new
  def new
    @ship = Ship.new
  end

  # GET /ships/1/edit
  def edit
  end

  # POST /ships
  # POST /ships.json
  def create
    @ship = Ship.new(ship_params)

    respond_to do |format|
      if @ship.save
        format.html do
          if params[:is_launch_wizard]
            current_user.ship = @ship
            current_user.save
            return redirect_to launch_wizard_new_ship_picture_path(ship_id: @ship.id), notice: 'Ship was successfully created.'
          end
          redirect_to @ship, notice: 'Ship was successfully created.'
        end
        format.json { render :show, status: :created, location: @ship }
      else
        format.html { render :new }
        format.json { render json: @ship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ships/1
  # PATCH/PUT /ships/1.json
  def update
    respond_to do |format|
      if @ship.update(ship_params)
        format.html { redirect_to @ship, notice: 'Ship was successfully updated.' }
        format.json { render :show, status: :ok, location: @ship }
      else
        format.html { render :edit }
        format.json { render json: @ship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ships/1
  # DELETE /ships/1.json
  def destroy
    @ship.destroy
    respond_to do |format|
      format.html { redirect_to ships_url, notice: 'Ship was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ship
      @ship = Ship.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ship_params
      params.require(:ship).permit(:name, :ship_class, :description, :passenger_capacity, :base_fare, :shield_rating, :armor_rating, :cargo_capacity)
    end
end
