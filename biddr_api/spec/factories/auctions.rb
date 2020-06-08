FactoryBot.define do
    factory :auction do
      title { "MyString" }
      description { "MyText" }
      starting_bid { 1.5 }
      active_bid { 1.5 }
      reserve_price { 1.5 }
      end_date { "2020-06-20 10:00:00" }
    end
  end