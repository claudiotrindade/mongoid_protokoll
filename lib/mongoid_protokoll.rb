require "mongoid_protokoll/version"
require "mongoid_protokoll/counter"
require "active_support/concern"

module Mongoid
  module Protokoll
    extend ActiveSupport::Concern
    
    module ClassMethods
      # Class method available in models
      #
      # == Example
      #   class Order < ActiveRecord::Base
      #      protokoll :number
      #   end
      #
      def protokoll(column, _options = {})
        field column, :type => String
        options = { :pattern       => "%Y%m#####",
                    :number_symbol => "#",
                    :column        => column,
                    :start         => 0 }

        options.merge!(_options)

        # Defining custom method
        send :define_method, "reserve_#{options[:column]}!".to_sym do
          self[column] = MongoidProtokoll::Counter.next(self, options)
        end

        # Signing before_create
        before_create do |record|
          unless record[column].present?
            record[column] = MongoidProtokoll::Counter.next(self, options)
          end
        end
      end
    end
  end
end
