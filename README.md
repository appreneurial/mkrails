# mkrails - Rails Application Generator

The **mkrails** Rails application generator consists of a BASH shell script (*mkrails.sh*) and a Ruby script (*mkrails.rb*), both of which work together to streamline the creation of new Rails applications.

The shell script (*mkrails.sh*) will:

1. Optionally create an empty directory for the new Rails application;
1. Create a project-specific gemset for the Rails application;
1. Install Rails to the project-specific gemset;
1. Generate a new Rails application using the *mkrails.rb* script as a template.

The Ruby script (*mkrails.rb*) will perform the following actions for all "recipes" specified when invoking the *mkrails.sh* script:

1. Install required gems to the project-specific gemset;
1. Initialize/configure installed gems;
1. Add/remove customized files within the Rails application;
1. Finalize/clean up after gem installation.

By default, the following "recipes" are applied to the new Rails application:

1. **bdd**: set up behaviour-driven development using the *rspec-rails*, *capybara* and *factory_girl_rails* gems;
1. **haml**: use the Haml templating engine (via the *haml-rails* gem), and use the *erb2haml* gem to replace all ERb files with Haml files;
1. **bootstrap**: use the Twitter Bootstrap framework (via the *less-bootstrap-rails* gem), update the Application layout to be more Bootstrap friendly, and include a BootstrapHelpers module to include helper methods for common Bootstrap components;
1. **font-awesome**: use the Font Awesome toolkit (via the *font-awesome-rails* gem);
1. **simple_form**: use Simple Form (version ~> 3.1.0.rc0 for better Bootstrap support) with the optional *country_select* gem;
1. **devise**: use Devise for authentication, customize the Devise views and set up Devise/RSpec integration;
1. **heroku**: set up prerequisites for deployment to Heroku;
1. **unicorn**: use the Unicorn web server;
1. **better_errors**: use Better Errors in development (along with the optional *binding_of_caller* gem);
1. **quiet_assets**: use Quiet Assets to suppress asset pipeline logging in development.

## Prerequisites

The **mkrails** shell script (*mkrails.sh*) depends on the Ruby Version Manager (RVM) to create the project-specific gemset.

## Installation

To install **mkrails** to your own development environment, save a copy of the *mkrails.sh* shell script to your local system, and add the following line to the end of your *~/.bashrc* file:

	source path_to_mkrails.sh

The **mkrails** function will now be available in any new shells.

## Usage

To invoke **mkrails** with default options (listed below), simple enter the following command in a terminal window:

	mkrails

Invoking **mkrails** without any options will generate a new Rails application in the current working directory, using the current working directory's basename as the application name.  This behaviour can be changed using the *--app-name* option (see below).

### Options

The **mkrails** script is designed to run unattended.  Instead of prompting for input during the application generation process, the behaviour of the **mkrails** script can be altered using the following command line options:

**--app-name=application_name** *(default: .)*

Instead of creating the new Rails application in the current directory, the shell script will create a new directory called *application_name* and generate the Rails application within that directory. The project-specific gemset will also be called *application_name*, and the titleized version of *application_name* (eg. "Application Name") will appear within the new application's layouts and meta data defaults.

**--database-provider=database_type** *(default: postgresql)*

The specified *database_type* will be passed to the *rails new* command using the *--database=* argument.

**--rails-version=a.b.c** *(default: 4.1.6)*

The specified version of the *rails* gem will be installed into the project-specific gemset.

**--recipes=abc,def,...,xyz** *(default: bdd,haml,bootstrap,font-awesome,simple_form,devise,heroku,unicorn,better_errors,quiet_assets)*

A comma-separated list of recipes to be applied during generation of the new Rails application (each of the default recipes are described briefly above).

**--ruby-version=x.y.z** *(default: 2.1.2)*

The project-specific gemset will be created using the specified version of Ruby.

**--site-owner="Your Name"** *(default: Jason Green)*

The specified name will be used as the site owner's name within the application layout (for the copyright message in the footer).

**--site-owner-url=http://yourwebsite.com** *(default: http://www.appreneurial.co)*

The site owner's name will be linked to the specified URL within the application layout.

**--source=path/url** *(default: https://raw.githubusercontent.com/appreneurial/mkrails/master)*

Specify the source for the *mkrails.rb* Ruby script and associated assets. This may be either a remote URL (such as the GitHub URL used by default), or a local path (useful if you have cloned the GitHub repository and customised the **mkrails** scripts, recipes or templates).

## Version History

**1.1.1** *(11/10/2014)*: Improve RSpec/Devise integration

**1.1.0** *(26/09/2014)*: Improve handling of meta data, social tags and header content

**1.0.0** *(25/09/2014)*: Initial release