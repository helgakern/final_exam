class AuctionCollectionSerializer < ActiveModel::Serializer
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
      has_many :bids
       belongs_to :user, key: :author
  end