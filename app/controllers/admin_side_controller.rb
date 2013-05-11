class AdminSideController < ApplicationController
	def index
		@clients = Client.all
		@lawyers = Lawyer.all
	end

	def search

	end
end
