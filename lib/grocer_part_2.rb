require_relative './part_1_solution.rb'
require "pry"


def apply_coupons(cart,coupons)
  coupons.each do |coupon_hash|
    #finds the coupon inside the cart, useful for our control flow logic
    coupon_inside_cart = find_item_by_name_in_collection("#{coupon_hash[:item]} W/ COUPON",cart)
    
    #finds the grocery_item in our cart, useful because we have to make changes to it if a coupon is present
    grocery_item = find_item_by_name_in_collection(coupon_hash[:item], cart)
    grocery_item_index = cart.find_index(grocery_item)
    

    if grocery_item && grocery_item[:count] >= coupon_hash[:num]
      if coupon_inside_cart
        coupon_inside_cart[:count] +=1
        cart[grocery_item_index][:count] -= coupon_inside_cart[:count]
        
      else
        adjusted_coupon =  {
        :item => "#{coupon_hash[:item]} W/COUPON",
        :price => coupon_hash[:cost]/coupon_hash[:num],
        :clearance => grocery_item[:clearance],
        :count => coupon_hash[:num]
        }
        #binding.pry
        cart.push(adjusted_coupon)
        cart[grocery_item_index][:count] -= adjusted_coupon[:count]
      end
  end 
    #end for the  control flow logic
       
  end #end for the each method
  cart
    #binding.pry
end #end for the method in general
  
  
def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart_with_clearance = cart.each do |grocery_item|
    if grocery_item[:clearance]
      grocery_item[:price] -= (grocery_item[:price] * 0.20).round(3)
    end
  end
  cart_with_clearance
  #binding.pry
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total
  consolidated_cart = consolidate_cart(cart)
  #check if there are any coupons
  
  cart_with_coupons = apply_coupons(consolidated_cart,coupons)
  cart_with_all_discounts = apply_clearance(cart_with_coupons)
  
  
  #now I will loop over the cart that has all the discounts
  total_price = 0.0
  #binding.pry
  cart_with_all_discounts.each do |cart_item|
    total_price += cart_item[:price] 
    #binding.pry
  end
  
  #check if total is over $100
  if total_price > 100
    total_price += total_price(0.10)
  end
  total_price
  binding.pry
end
