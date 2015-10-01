require "rubygems"
require "google/api_client"
require "google_drive"
require 'uri'
require 'net/http'

class ViewFilesController < ApplicationController
  before_action :set_view_file, only: [:show, :edit, :update, :destroy]

  def authorize
    redirect_to auth.authorization_uri.to_s
  end

  def access_token
    if params[:code].blank?
      redirect_to view_files_authorize_path
    else
      z = auth
      z.code = params[:code]
      z.fetch_access_token!
      session[:access_token] = z.access_token
      redirect_to view_files_path
    end
  end

  def index
    @view_files = list_files
  end

  def show
  end

  def new
    @view_file = ViewFile.new
  end

  def edit
  end

  def create
    @view_file = ViewFile.new(view_file_params)

    respond_to do |format|
      if @view_file.save
        format.html { redirect_to @view_file, notice: 'View file was successfully created.' }
        format.json { render :show, status: :created, location: @view_file }
      else
        format.html { render :new }
        format.json { render json: @view_file.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @view_file.update(view_file_params)
        format.html { redirect_to @view_file, notice: 'View file was successfully updated.' }
        format.json { render :show, status: :ok, location: @view_file }
      else
        format.html { render :edit }
        format.json { render json: @view_file.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @view_file.destroy
    respond_to do |format|
      format.html { redirect_to view_files_url, notice: 'View file was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_view_file
      @view_file = ViewFile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def view_file_params
      params[:view_file]
    end

  def list_files
    drive_session.files
  end

  def drive_session
    GoogleDrive.login_with_oauth(session[:access_token])
  end

  def auth
    client = Google::APIClient.new
    auth = client.authorization
    auth.client_id = '1074600807391-9b98gs5d8k151pj6ajpf1q5i4cgkst1i.apps.googleusercontent.com'
    auth.client_secret = 'kgH8RYgPPL9GABLwCsdjJ3lx'
    auth.scope = "https://www.googleapis.com/auth/drive https://spreadsheets.google.com/feeds/"
    auth.redirect_uri = 'http://ditommasoquinonesschwab-grupo8dssd/view_files/access_token'
    auth
  end

end
