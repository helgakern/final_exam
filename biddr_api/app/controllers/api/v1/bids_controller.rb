class Api::V1::BidsController < Api::ApplicationController

    before_action :authenticate_user!, except: [:index, :show]
    before_action :find_bid, only: [ :destroy]
  
    rescue_from(ActiveRecord:: RecordNotFound, with: :record_not_found)
    rescue_from(ActiveRecord:: RecordInvalid, with: :record_invalid)
  
    def index
      @auction = Auction.find(params[:auction_id])
      bids = Bid.order(created_at: :desc)
      render(json: bids)
    end
  
    def show
      if @bid
      render(
        json: @bid    )
      else
        render(json: {error: 'Bid Not found'})
      end
    end
  
    def create
      auction = Auction.find(params[:auction_id])
      bid = Bid.new bid_params
      bid.auction = auction
      bid.user = current_user
      bid.save!
      render json: { id: bid.id }
    end
  
    def destroy
      @bid.destroy
      render(json: { status: 200 }, status: 200)
    end
  
    private
  
    def find_bid
      @bid ||= Bid.find params[:id]
    end
  
    def bid_params
      params.require(:bid).permit(:amount)
    end
  
    def record_not_found
      render(
        json: { status: 422, errors: {msg: 'Record Not Found'}},
        status: 422
      )
    end
  
    def record_invalid(error) 
      invalid_record = error.record 
      errors = invalid_record.errors.map do |field, message|
      {
        type: error.class.to_s, 
        record_type: invalid_record.class.to_s,
        field: field,
        message: message
      }
      end
      render(
        json: { status: 422, errors: errors }
      )
    end
  
  end