class CreateStructure < ::RailsConnector::Migration
  def up
    delete_obj_by_path('/logo.png')
    delete_obj_by_path('/')

    try_update_obj_class('Publication', :is_active => false)

    try_create_obj(:_path => '/', :_obj_class => 'Root')
    try_update_obj_class('Root', :is_active => false)

    try_create_obj(:_path => '/website', :_obj_class => 'Website')

    try_create_obj(:_path => '/website', :_obj_class => 'Homepage', :title => 'Startseite')

    try_create_obj(:_path => '/website/de/_configuration', :_obj_class => 'Container', :title => '_Configuration')

    try_create_obj(:_path => '/website/de/beispiel', :_obj_class => 'ContentPage', :title => 'Beispielseite')

    try_create_obj(:_path => '/website/de/_configuration/error_404', :_obj_class => 'ErrorPage', :title => 'Seite nicht gefunden', :body => 'Leider ist die Seite nicht da.', :show_in_navigation => 'No')
    try_create_obj(:_path => '/website/de/_configuration/login', :_obj_class => 'LoginPage', :title => 'Anmelden')
    try_create_obj(:_path => '/website/de/_configuration/search', :_obj_class => 'SearchPage', :title => 'Suche')
    try_update_obj(
      Obj.find_by_path('/website/de').id,
      :error_404_page => [{ :url => '/website/de/_configuration/error_404' }],
      :login_page => [{ :url => '/website/de/_configuration/login' }],
      :search_page => [{ :url => '/website/de/_configuration/search' }],
      :locale => 'de'
    )

    try_create_obj(:_path => '/resources', :_obj_class => 'Container', :title => 'Resources')
    try_create_obj(:_path => '/resources/images', :_obj_class => 'Container', :title => 'Images')
    try_create_obj(:_path => '/resources/audio', :_obj_class => 'Container', :title => 'Audio')
    try_create_obj(:_path => '/resources/videos', :_obj_class => 'Container', :title => 'Videos')
    try_create_obj(:_path => '/resources/pdfs', :_obj_class => 'Container', :title => 'Pdfs')

    try_create_obj(:_path => '/website/de/_boxes', :_obj_class => 'Container', :title => '_Boxes')
    try_create_obj(:_path => '/website/de/_boxes/box_text', :_obj_class => 'BoxText', :title => 'BoxText', :body => 'Inhalt von BoxText', :sort_key => '1')
    try_create_obj(:_path => '/website/de/_boxes/box_image', :_obj_class => 'BoxImage', :title => 'BoxImage', :caption => 'Inhalt von BoxImage', :source => [{:url => 'http://lorempixel.com/400/200/sports/1/'}], :sort_key => '2')
  end

  private

  def try_update_obj_class(id, attributes)
    update_obj_class(id, attributes)
  rescue RailsConnector::ClientError => error
    puts error.message
    puts 'Some aspects of the ICE Kickstarter may not work as expected.'
  end

  def try_create_obj(attributes = {})
    create_obj(attributes)
  rescue RailsConnector::ClientError => error
    puts error.message
    puts 'Some aspects of the ICE Kickstarter may not work as expected.'
  end

  def try_update_obj(id, attributes = {})
    update_obj(id, attributes)
  rescue RailsConnector::ClientError => error
    puts error.message
    puts 'Some aspects of the ICE Kickstarter may not work as expected.'
  end

  def delete_obj_by_path(path)
    obj = Obj.find_by_path(path)

    if obj
      delete_obj(obj.id)
    else
      puts "[delete obj] The object at '#{path}' does not exist."
    end
  end
end