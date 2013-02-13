module UserManager
  class WebCrmMapper
    # Maps attributes to the given user. This maps in the opposite direction of
    # the save method.
    def update(user, attributes)
      mapped = map_attributes(mapping.invert, attributes)

      # Do not override changed user attributes.
      mapped.except!(*user.changed)

      # Only update user attributes and reject anything else.
      mapped.slice!(*user.class.attribute_names)

      user.attributes = mapped

      user
    end

    # Maps attributes to the given remote user. This maps in the opposite
    # direction of the update method.
    def save(contact, attributes)
      attributes = map_attributes(mapping, attributes)

      contact.update_attributes(attributes)

      contact
    end

    private

    # The mapping includes all attributes that differ between the application
    # user and the remote user model. The hash keys represent the application
    # user attributes and the hash values the names of the attributes in the
    # remote user model.
    def mapping
      {
        city: :locality,
        company: :org_name_address,
        department: :org_unit_address,
      }
    end

    # Uses a mapping to change the hash keys of the attributes hash to their
    # corresponding name in the mapping, leaving the values untouched.
    def map_attributes(mapping, attributes)
      attributes = mapping.inject(attributes) do |hash, (from, to)|
        hash[to.to_s] = hash.delete(from.to_s)

        hash
      end
    end
  end
end