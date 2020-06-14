class AuctionSerializer < ActiveModel::Serializer
    attributes(
      :id,
      :title,
      :description,
      :starting_bid,
      :active_bid,
      :reserve_price,
      :end_date,
      :created_at,
      :updated_at,
      :aasm_state
      )
  
      # To include associated models, use the same named methods
      # used for creating associations. You can rename the association with
      # 'key' which is only going to show in the rendered json
      has_many :bids
      belongs_to :user, key: :author
  
     class BidSerializer < ActiveModel::Serializer
       # This will be used to serialize the answers from
       # 'has_many :answers'
       attributes :id, :amount, :created_at, :updated_at
       belongs_to(:user, key: :author)
     end
    end