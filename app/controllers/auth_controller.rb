class AuthController < ApplicationController
  before_action :authorize_request, only: [:verify]

  def sign_up
    if User.find_by(email: params[:email]).nil?
      @user = User.new

      @user.email = params[:email]
      @user.name = params[:name]
      @user.username = params[:username]
      @user.password = params[:password]
      @user.avatar = params[:avatar]
      @user.likes = []
      @user.save

      render json: { success: true, result: @user }
    else
      render json: { success: false, error: '해당 이메일이 이미 사용되었습니다.' }
    end
  end

  def login
    @email = params[:email]
    @password = params[:password]
    @user = User.find_by(email: @email)

    if @user && @user.password == @password
      @token = encode_token(@user.id, @user.email, @user.username)
      render json: { success: true, token: @token }
    else
      render json: { success: false, error: '이메일 또는 비밀번호가 틀렸습니다.' }
    end
  end

  def verify
    @token = params[:token]
    render json: { success: true, result: JWT.decode(@token, Rails.application.secrets.secret_key_base)[0] }
  end

  def encode_token(id, email, username)
    payload = { id: id, email: email, username: username, exp: (Time.now + 72.hour).to_i }
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end
end