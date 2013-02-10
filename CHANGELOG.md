= v0.0.3
  * Added authorization support to simply protect access to a page via a before filter. Use
    ```before_filter Filters::Authorization``` in your controller to protect the entire page.
  * Complete refactoring of user management. Separated application user model from its remote user
    model by introducing an application wide user manager. A default implementation is given for the
    Infopark WebCRM. This makes it possible to easily swap the user manager to LDAP for example. A
    mapper class is used for the communication between the two, possibly different, user models.
    Have a look at ```app/models/user.rb``` for how it is implemented exactly.
  * Added optional contact_page component that is connected to the WebCRM and prefills email, when
    user is logged in. Call ```rails generate cms:component:contact_page```.
  * Added ICE Developer Dashboard mounted under ```/cms/dashboard```. The dashboard
    is only available for local requests.
  * Bugfix: Workspace Toggle no longer displays an empty list, when there is only one workspace.
  * Changed ```rake cms:deploy:live``` to ```rake cms:deploy``` as there is no other environment yet.
  * Added optional google analytics generator. Tracking ID and Anonymize IP Setting can
    be configured in the CMS for each homepage. Default settings can be given as generator
    options.

= v0.0.2
  * initial functionality