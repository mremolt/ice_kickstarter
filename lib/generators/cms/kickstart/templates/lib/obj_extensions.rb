module ObjExtensions

  # Infopark Rails Connector enables the developer to define specific behavior for Fiona CMS
  # classes by using Single Table Inheritance (http://www.martinfowler.com/eaaCatalog/singleTableInheritance.html).
  #
  # If you wish to decorate the Obj model with extra behavior, you will need to add it here.
  #
  # Be careful only to use methods and classes that are part of the documented api.
  # Other methods and classes may change without warning.

  def self.enable
    return if Obj.respond_to? :obj_extensions_enabled

    require "lib/page"
    require "lib/box"

    Obj.class_eval do

      def self.obj_extensions_enabled
      end

      # Add custom extensions to the Obj model below
      #

      def self.homepage
        default_homepage
      end

      def self.default_homepage
        Homepage.homepage_for_hostname('default')
      end

      def homepage
        parent.homepage
      end

      def website
        homepage.website
      end

      def main_nav_item
        parent.main_nav_item
      end

      def sorted_toclist
        toclist.sort_by {|obj| obj[:sort_key].to_s}
      end

      def related_links
        self[:related_links] || []
      end

      def boxes
        boxes_dir = Obj.find_by_path(path + '/_boxes')
        if boxes_dir.present?
          boxes_dir.sorted_toclist.select { |c| Box === c }
        else
          []
        end
      end

      # Return a page object or nil.
      #
      # Normally, objects are either pages, boxes, or media files/resources.
      # Pages are pages in itself, Boxes are treated differently. Media files
      # and resources are filtered out.
      #
      # This method can be overridden by subclasses to implement this behaviour.
      def page
        nil
      end

      def show_in_navigation?
        self[:show_in_navigation] != 'Yes'
      end

      def language
        homepage.name
      end
    end
  end
end