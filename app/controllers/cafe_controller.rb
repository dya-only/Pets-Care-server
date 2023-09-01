require 'to_json_fix'

class CafeController < ApplicationController
  def add
    @id = params[:id]
    @name = params[:name]
    @latitude = params[:latitude]
    @longitude = params[:longitude]

    @user = User.find_by(id: @id)
    @likes = JSON.parse(@user.likes)

    @cnt = 0
    @likes.each do |x|
      if x['latitude'] == @latitude && x['longitude'] == @longitude
        @cnt += 1
      end
    end

    if @cnt == 0
      @likes.push({ name: @name, latitude: @latitude, longitude: @longitude })
      @user.likes = @likes.to_json
      @user.save

      render json: { message: @user }, status: :ok

    else
      if @likes.length >= 10
        render json: { message: '사용 가능한 좋아요 수를 넘었습니다.' }, status: :forbidden
      else
        render json: { message: '이미 저장된 카페입니다.' }, status: :already_reported
      end
    end
  end

  def remove
    @id = params[:id]

  end

  def getLikes
    @id = params[:id]
    @user = User.find_by(id: @id)
    @likes = JSON.parse(@user.likes)

    render json: @likes
  end
end