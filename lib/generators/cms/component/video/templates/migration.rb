class CreateVideo < ::RailsConnector::Migration
  def video_attribute
    'video_file'
  end

  def class_name
    '<%= class_name %>'
  end

  def up
    create_attribute(
      name: video_attribute,
      title: 'Video File',
      type: :string
    )

    create_obj_class(
      name: class_name,
      type: 'publication',
      title: 'Video',
      attributes: [
        video_attribute
      ]
    )
  end
end