class UserController < ApplicationController
  before_action :authorize_request

  def getAll
    render json: { success: true, result: User.all }
  end

  def findById
    @user = User.find_by(id: params[:id])

    if !@user.nil?
      render json: { success: true, result: @user }
    else
      render json: { success: false, result: @user }
    end
  end

  def getLikes
    @id = params[:id]
    @user = User.find_by(id: @id)
    @likes = JSON.parse(@user.likes)

    render json: { success: true, result: @likes }
  end

  def uploadAvatar
    @id = params[:id]
    @avatar = params[:avatar]

    @user = User.find_by(id: @id)
    @user.avatar = @avatar
    @user.save

    render json: { success: true, result: @user }
  end
end