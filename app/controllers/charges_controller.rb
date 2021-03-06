class ChargesController < ApplicationController
 include Accessible 

  def index
  	@charges = Charge.all
  end

  def new
  	@charge = Charge.new
  end


#  def create
#    puts " Entro"
#    @charge = Charge.new(charge_params)
#    order = @charge.order
#    order.status = 'payment'    
#    if order.save && @charge.save
#      render :epayco
#    else
#      render :newstau
#    end
#  end


# lines 31 and 33 to be checked!!!

def create
    puts " ON CREATED CONTROLLER"
    @charge = Charge.new(charge_params)
    
    @order = @charge.order
    if Rails.env == "production"

      #@order.status = 'payment'    
      if  @charge.save #@order.save &&
       
        render :epayco
      else
        render :new
      end
    else
      puts "   DEVELOPMENT. ORDER SENT FOR PAYMENT!!! @ORDER.STATUS before setting status to update  #{@order.status.capitalize} "

      @order.status = 'posted'  
      @order.save
      puts "   DEVELOPMENT. ORDER SENT FOR PAYMENT!!! @ORDER.STATUS is #{@order.status.capitalize} "
      respond_to do |format|
        #sends notification to sender saying that order has been sent
        if @order.save
          puts "   Notification Sent to Sender #{@order.sender.id}"
          NotificationChannel.broadcast_to(@order.sender,
                title: 'Notificación', 
                body: "El Estado de la <a href=""#{url_for([@order.sender, @order])}""> orden No: #{@order.id.to_s} </a>, 
                      ha cambiado.")

          format.html { redirect_to url_for([@user, @order]), notice: 'Order successfully sent for payment.' }
          format.json { render :show, status: :created, location: @order }

        else
          format.html { render :new }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private

  def charge_params
  	params.require(:charge).permit(:amount, :order_id)
  end

end
