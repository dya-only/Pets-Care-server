class CafeController < ApplicationController
  def add
    @id = params[:id]
    @name = params[:name]
    @latitude = params[:latitude]
    @longitude = params[:longitude]

    if Cafe.find_by(latitude: @latitude) && Cafe.find_by(longitude: @longitude)
      render json: { message: '이미 추가되어있는 카페입니다.' }, status: :multiple_choices
    else
      @cafe = Cafe.new
      @cafe.name = @name
      @cafe.latitude = @latitude
      @cafe.longitude = @longitude
      @cafe.save

      @user = User.find_by(id: @id)
      @likes = JSON.parse(@user.likes)

      @likes.push(@cafe.id)
      @user.likes = @likes.to_s
      @user.save

      render json: { message: @user }, status: :ok
    end
  end

  def remove
    @id = params[:id]

  end

  def getLikes
    @id = params[:id]
    @user = User.find_by(id: @id)
    @likes = @user.likes
  end
end