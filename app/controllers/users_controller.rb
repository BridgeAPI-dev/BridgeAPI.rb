require 'bcrypt'
require 'pry'

class UsersController < ApplicationController
  # has_secure_password 
  
  def create 
    username = params[:username]
    password = params[:password]
    password_hash = BCrypt::Password.create(password)

    binding.pry 
    # we need a password from the params (params[:password])
    # we need a username from the params (params[:email]) 
    # Need to make those strong parameters! 
    
    # then we hash the password with bcrypt 
    # then we instantiate the User 
    # => if that works, then we call save! on the user and return a successful object? (research this)
  # If that doesn't work, return a negative object (research this)  
  end

  def destroy 
    # Validate the user 
    # Then delete user from the database  
  end

  def update 
    # Validate the user 
    # hash the password
    # The set username and password to the user and save to database
  end
end