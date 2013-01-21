class Homepage < Obj
  include Page

  # TODO edit mapping from hostnames to homepages
  def self.homepage_for_hostname(hostname)
    find_by_path(
      case hostname
      when /foo\.de/, /foo-(live|staging)\.infopark\.de/, /foo\.dev/
        '/foo/de'
      else
        # Default homepage
        '/website/de'
      end
    )
  end

  # TODO edit mapping from homepages to hostnames
  # Inverse of #homepage_for_hostname
  def desired_hostname
    if path.start_with?('/foo/de')
      Rails.env.staging? ? 'foo-staging.infopark.de' : 'www.foo.de'
    else
      # Default hostname
      Rails.env.staging? ? 'website-staging.infopark.de' : 'www.website.de'
    end
  end

  def homepage
    self
  end

  def website
    parent
  end

  def main_nav_item
    nil
  end

  def get_object(named_link_name)
    link = related_links.detect {|link| link.title == named_link_name}
    obj = link && link.destination_object
    unless obj
      raise "Named Object #{named_link_name} not found for Homepage #{path}"
    end
    obj
  end
end