class CreateStructure < ::RailsConnector::Migrations::Migration
  def up
    delete_obj_by_path('/logo.png')
    delete_obj_by_path('/')

    create_obj(:_path => '/', :_obj_class => 'Root')
    update_obj_class('Root', :is_active => false)

    create_obj(:_path => '/website', :_obj_class => 'Website')

    create_obj(:_path => '/website/de', :_obj_class => 'Homepage', :title => 'Startseite')

    create_obj(:_path => '/website/de/_meta', :_obj_class => 'Publication')

    create_obj(:_path => '/website/de/beispiel', :_obj_class => 'ContentPage', :title => 'Beispielseite')

    create_obj(:_path => '/website/de/_meta/error_404', :_obj_class => 'ErrorPage', :title => 'Seite nicht gefunden', :body => 'Leider ist die Seite nicht da.', :show_in_navigation => 'No')
    create_obj(:_path => '/website/de/_meta/login', :_obj_class => 'LoginPage', :title => 'Anmelden')
    create_obj(:_path => '/website/de/_meta/search', :_obj_class => 'SearchPage', :title => 'Suche')
    update_obj(
      Obj.find_by_path('/website/de').id,
      :error_404_page => [{ :url => '/website/de/_meta/error_404' }],
      :login_page => [{ :url => '/website/de/_meta/login' }],
      :search_page => [{ :url => '/website/de/_meta/search' }],
      :locale => 'de'
    )

    create_obj(:_path => '/resources', :_obj_class => 'Publication', :title => 'Resources')
    create_obj(:_path => '/resources/images', :_obj_class => 'Publication', :title => 'Images')
    create_obj(:_path => '/resources/audio', :_obj_class => 'Publication', :title => 'Audio')
    create_obj(:_path => '/resources/videos', :_obj_class => 'Publication', :title => 'Videos')
    create_obj(:_path => '/resources/pdfs', :_obj_class => 'Publication', :title => 'Pdfs')

    create_obj(:_path => '/website/de/_boxes', :_obj_class => 'Publication')
    create_obj(:_path => '/website/de/_boxes/box_text', :_obj_class => 'BoxText', :title => 'BoxText', :body => 'Inhalt von BoxText', :sort_key => '1')
    create_obj(:_path => '/website/de/_boxes/box_image', :_obj_class => 'BoxImage', :title => 'BoxImage', :caption => 'Inhalt von BoxImage', :source => [{:url => 'http://lorempixel.com/400/200/sports/1/'}], :sort_key => '2')
  end

  private

  def delete_obj_by_path(path)
    obj = Obj.find_by_path(path)

    if obj
      delete_obj(obj.id)
    end
  end
end