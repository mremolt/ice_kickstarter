# ICE Kickstarter

The Kickstarter provides generators and rake tasks to quickly setup or enhance an [Infopark
Cloud Express](http://infopark.de/infopark-cloud-express) Ruby on Rails project. All generated code
represents a working example, but can be fully customized within the application.

## Installation

Add this line to your application's Gemfile:

    gem 'ice_kickstarter'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ice_kickstarter

## Usage

To generate the basic code and CMS structure:

    $ rails generate cms:kickstart
    
## CMS Structure

When the ```cms:kickstart``` generator is finished the following CMS hierarchy is created:

    |- website
    |    |- homepage
    |        |- _meta
    |            |- error_page
    |            |- login_page
    |            |- search_page
    |
    |- resources
        |- videos
        |- audio
        |- images
        |- pdfs
        
Together with the CMS hierarchy, some CMS object classes and attributes are created as well:

### Attributes ###

* show_in_navigation:enum (Yes No)
* error_404_page:linklist
* search_page:linklist
* locale:string
* source:linklist
* caption:string
* sort_key:string

### Object Classes ###

* Root
* Homepage
* Website
* ContentPage
* ErrorPage
* LoginPage
* SearchPage
* BoxText
* BoxImage

## Generators

To get an overview of all provided generators:

    $ rails generate

To create a new CMS attribute:

    $ rails generate cms:attribute

To create a new CMS object class:

    $ rails generate cms:model

To create a new controller and index view based on a CMS object class:

    $ rails generate cms:controller

The two above generators (cms:model and cms:controller) can be combined in one generator:

    $ rails generate cms:scaffold

## Rake Tasks

To get an overview of all provided rake tasks:

    $ rake -T cms

To run all cms migrations:

    $ rake cms:migrate

The command only processes new, not yet released CMS migrations that are placed in the
```cms/migrate``` directory. Migrations are ordered by their version number.

To publish all processed migrations:

    $ rake cms:migration:publish

To delete all migrations that are not published (deletes the ```rtc workspace```):

    $ rake cms:migration:abort

To deploy the ```origin/master``` branch to the live servers:

    $ rake cms:deploy:live

To get deployment status for last deployment (or given deployment id):

    $ rake cms:deploy:status[id]

To list github users allowed to access the project repository:

    $ rake cms:github:list

To show access information for github user:

    $ rake cms:github:show[username]

To add github user with ```pull``` (read-only, default) or ```push``` (read and write) permission:

    $ rake cms:github:add[username,permission]

To change access permission of github user to ```pull``` (read-only) or ```push``` (read and write):

    $ rake cms:github:change[username,permission]

To disallow github user to access the project repository:

    $ rake cms:github:remove[username]

## Changelog

See [Changelog](https://github.com/infopark/ice_kickstarter/blob/master/CHANGELOG.md) for more
details.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License
Copyright (c) 2009 - 2012 Infopark AG (http://www.infopark.com)

This software can be used and modified under the LGPLv3. Please refer to http://www.gnu.org/licenses/lgpl-3.0.html for the license text.
