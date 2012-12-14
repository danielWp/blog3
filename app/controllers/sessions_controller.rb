class SessionsController < ApplicationController
	protect_from_forgery
  	include SessionsHelper
  	
	def new
	end

	def create
	  	user = User.find_by_email(params[:session][:email].downcase)
	  	if user && user.authenticate(params[:session][:password])
	    	# Sign the user in and redirect to the user's show page.
	  	else
	    	# Error message and re-render the signin form.
	    	flash.now[:error] = 'Combinacao de email/password invalida' # Not quite right!
	      	render 'new'
	  	end
	end

	def destroy
		sign_out
    	redirect_to root_url
	end
end
