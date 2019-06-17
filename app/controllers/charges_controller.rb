class ChargesController < ApplicationController
  
  def index
  	@charges = Charge.all
  end

  def new
  	@charge = Charge.new
  end

  def create
  	@charge = Charge.new(charge_params)
  	if @charge.save
  		render :epayco
  	else
  		render :new
  	end
  end

  private

  def charge_params
  	params.require(:charge).permit(:amount)
  end

end
