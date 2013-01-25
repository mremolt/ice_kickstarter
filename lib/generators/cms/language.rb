module Cms
  module Generators
    module Language
      def self.included(base)
        base.class_option :language,
          :type => :string,
          :aliases => '-l',
          :default => 'en',
          :desc => 'Language of the generated content.'
      end

      private

      def language
        options['language']
      end
    end
  end
end