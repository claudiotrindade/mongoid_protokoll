module MongoidProtokoll
  module Models
    class CustomAutoIncrement
      include Mongoid::Document
      include Mongoid::Timestamps
      
      field :model_name, type: String
      field :counter, type: Integer, default: 0
      field :updated_at, type: Time, default: Time.now
    end
  end
end