class CardsController < ApplicationController
	before_action :authenticate_user!

	def create
		@project = Project.find(params[:project_id])
		@card = Card.new(project: @project)
		respond_to do |format|
			if @card.save
				format.html { redirect_to @project, notice: "Look at all of these cards!" }
				format.js
			else
				format.html { redirect_to @project, alert: "You're dumb, yo!" }
			end
		end
	end

	def update
	  @card = Card.find(params[:id])
	  respond_to do |format|
	    if @card.update(params.require(:card).permit(:title, :body))
	      format.html { redirect_to(@card.project, notice: 'Card was successfully updated.') }
	      format.json { respond_with_bip(@card) }
	    else
	      format.html { render action: "edit" }
	      format.json { respond_with_bip(@card) }
	    end
	  end
	end

	def destroy
		@card = Card.find(params[:id])
		respond_to do |format|
			if @card.destroy
				format.html { redirect_to @card.project, notice: "Card was deleted" }
				format.js {render nothing: true }
			else
				format.html { redirect_to @card.project, alert: "Card could not be deleted!"}
			end 
		end
	end

	def sort
		cards = params[:card]
		cards.each_with_index do |card, index|
			Card.find(card).update(position: index)
		end
		respond_to do |format|
			format.js { render nothing: true }
		end
	end
end
