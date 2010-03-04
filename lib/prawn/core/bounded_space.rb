module Prawn
  module Core
    class BoundedSpace

      def initialize(options)
        update_sides(options)
        @saved_spaces = []
      end

      def update_sides(options)
        @sides = {}

        [:top, :bottom, :left, :right].each do |side|
          @sides[side] = options[side] || 0
        end
      end

      [:top, :bottom, :left, :right].each do |side|
        define_method side do
          @sides[side]
        end

        define_method "#{side}=" do |v|
          @sides[side] = v
        end
      end

      def width=(w)
        sides[:right] = sides[:left] + w
      end

      def height=(h)
        sides[:bottom] = sides[:top] - h
      end

      def save
        @saved_spaces << @sides
        @sides = @sides.dup
      end

      def restore
        @sides = @saved_spaces.pop
      end
     
      def shift(options = {})
        sides[:left]   += options[:left]   || 0
        sides[:bottom] += options[:bottom] || 0
        sides[:top]    += options[:top]    || 0
        sides[:right]  += options[:right]  || 0
      end

      attr_reader :sides
    end
  end
end


