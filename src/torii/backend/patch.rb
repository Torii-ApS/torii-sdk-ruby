# frozen_string_literal: true

module Torii
  module Backend
    # Tri-state wrapper for PATCH body fields.
    #
    # - Patch.set(value) -> server updates field to value
    # - Patch.clear      -> server clears field (JSON null on the wire)
    # - omit the kwarg entirely -> server leaves field alone
    class Patch
      attr_reader :state, :value

      STATE_SET   = :set
      STATE_CLEAR = :clear

      def initialize(state, value = nil)
        raise ArgumentError, "state must be :set or :clear" unless [STATE_SET, STATE_CLEAR].include?(state)
        @state = state
        @value = value
      end

      def self.set(value)
        new(STATE_SET, value)
      end

      CLEAR = new(STATE_CLEAR).freeze
      def self.clear
        CLEAR
      end

      def set?;   @state == STATE_SET;   end
      def clear?; @state == STATE_CLEAR; end
    end
  end
end
