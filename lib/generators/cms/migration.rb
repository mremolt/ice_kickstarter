module Cms
  module Generators
    class DuplicateResourceError < StandardError
    end

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

      private

      def validate_attribute(name)
        if attribute_exists?(name)
          error = DuplicateResourceError.new("CMS attribute '#{name}' already exists.")

          say_status(:exist, error.message, :blue)

          raise error
        end
      end

      def validate_obj_class(name)
        if obj_class_exists?(name)
          error = DuplicateResourceError.new("CMS object class '#{name}' already exists.")

          say_status(:exist, error.message, :blue)

          raise error
        end
      end

      def attribute_exists?(name)
        revision_id = workspace.revision_id
        endpoint = "revisions/#{revision_id}/attributes/#{name}"

        resource_exists?(endpoint)
      end

      def obj_class_exists?(name)
        revision_id = workspace.revision_id
        endpoint = "revisions/#{revision_id}/obj_classes/#{name}"

        resource_exists?(endpoint)
      end

      def resource_exists?(endpoint)
        ::RailsConnector::CmsRestApi.get(endpoint).present?
      rescue RailsConnector::ClientError
        false
      end

      def workspace
        ::RailsConnector::Workspace.current
      end
    end
  end
end