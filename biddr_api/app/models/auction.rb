class Auction < ApplicationRecord
    has_many(:bids, dependent: :destroy)
    belongs_to :user
    before_validation :set_default_reserve_price
  
  
    # validates(:title, presence: true, uniqueness: true)
    # validates :description,
    #             presence: { message: "must exist"}, length: { minimum: 2 }
  
    scope :viewable, -> { 
      where(aasm_state: [:published, :reserve_met])
    }
  
    #State machines
    include AASM
  
    aasm whiny_transitions: false do
      state :draft, initial: true
      state :published
      state :reserve_met
  
      event :publish do
        transitions from: :draft, to: :published
      end
  
      event :reserve_minimum do
        transitions from: :published, to: :reserve_met
      end
    end
  
    private
  
    def set_default_reserve_price
      # If you are writing to an attribute accessor,
      # you must prefix with self. which you do not
      # have to do if you are just reading it insead
      self.reserve_price ||= 1
    end
  
  end