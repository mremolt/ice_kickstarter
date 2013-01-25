module Cms
  module Generators
    module Migration
      def self.included(base)
        base.send(:include, ::Rails::Generators::Migration)
        base.send(:extend, ClassMethods)
      end

      module ClassMethods
        def next_migration_number(dirname)
          current_migration_number(dirname) + 1
        end
      end
    end
  end
end