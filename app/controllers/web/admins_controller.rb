# frozen_string_literal: true

class Web::AdminsController < ApplicationController
  before_action :set_web_admin, only: %i[show edit update destroy]

  # GET /web/admins or /web/admins.json
  def index
    @web_admins = Web::Admin.all
  end

  # GET /web/admins/1 or /web/admins/1.json
  def show; end

  # GET /web/admins/new
  def new
    @web_admin = Web::Admin.new
  end

  # GET /web/admins/1/edit
  def edit; end

  # POST /web/admins or /web/admins.json
  def create
    @web_admin = Web::Admin.new(web_admin_params)

    respond_to do |format|
      if @web_admin.save
        format.html { redirect_to web_admin_url(@web_admin), notice: 'Admin was successfully created.' }
        format.json { render :show, status: :created, location: @web_admin }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @web_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /web/admins/1 or /web/admins/1.json
  def update
    respond_to do |format|
      if @web_admin.update(web_admin_params)
        format.html { redirect_to web_admin_url(@web_admin), notice: 'Admin was successfully updated.' }
        format.json { render :show, status: :ok, location: @web_admin }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @web_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /web/admins/1 or /web/admins/1.json
  def destroy
    @web_admin.destroy

    respond_to do |format|
      format.html { redirect_to web_admins_url, notice: 'Admin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_web_admin
    @web_admin = Web::Admin.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def web_admin_params
    params.fetch(:web_admin, {})
  end
end
