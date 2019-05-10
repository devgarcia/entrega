class PostedOrderJob < ApplicationJob #ActiveJob::Base
  queue_as :default

  def perform(order_id)
  order = Order.find(order_id)

    if order.status == 'posted'  
      if order.radius < MAX_RADIUS
	      order.radius += DELTA_RADIUS
	      order.save	             
        PostedOrderJob.set(wait: 3.second).perform_later(order.id) # DELTA_TIME
      else 
        order.status = 'draft'         
        order.radius = 500
        order.save       
      end
    end
  end
end