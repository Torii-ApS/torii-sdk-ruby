# frozen_string_literal: true

module Torii
  module Backend
    # Tri-state wrapper for PATCH body fields. Mirrors the server-side
    # Kotlin PatchValue<T> (Included + NotIncluded; Included(nil) clears).
    #
    # - Patch.set(value) with a non-nil value -> server updates field
    # - Patch.set(nil)                        -> server clears field (JSON null)
    # - omit the kwarg entirely               -> server leaves field unchanged
    class Patch
      attr_reader :value

      def initialize(value)
        @value = value
      end

      def self.set(value)
        new(value)
      end
    end
  end
end
