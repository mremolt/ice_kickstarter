module Cms
  module Errors
    class MissingAttribute < StandardError
      def self.notify(obj, file_path)
        file_name = file_path.split('/').last
        klass = file_name.split('.').first.camelcase

        raise new(obj, klass)
      rescue MissingAttribute => error
        Rails.logger.info(error.message)
      end

      def initialize(obj, attribute)
        super("'#{attribute}' was accessed by object class '#{obj.class}' but is not available.")
      end
    end
  end
end