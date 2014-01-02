# Companies Manager

A proof of concept for a simple json webservice written in Ruby using Sinatra as a backend API and [backbone](http://backbonejs.org/)as frontend client that supports the following:

* Create new company
* Get a list of all companies
* Get details about a company
* Able to update a company
* Able to attach pdf-versions of passport(s) of the directors and beneficial owner(s) of the company

A company has the following attributes:

* Company ID
* Name
* Address
* City
* Country
* E-mail (not required)
* Phone Number (not required)
* One or more directors and beneficial owners.


## Install:

    $: git clone https://github.com/yortz/manager.git
    $: cd manager
    $: bundle
    $: rake db:create
    $: rake db:migrate
    $: rake db:seed
    
## Start:

Start up your app by issuing the following command:
    
    $: rake rerun 'rackup'

This will use [rerun](https://github.com/alexch/rerun) to automatically reload your app whenever you edit a file that is part of sinatra's fileystem.
You can open a new terminal window to automatically watch for changes and compile your .coffee, .js, .css, .scss files by issuing the following command thanks to [guard](https://github.com/guard/guard)

    $: rake guard

## Test:

    $: rake spec #runs specs
    $: rake test #runs js specs

## Contribute:

* Fork repo
* Create your feature branch: `git checkout -b feature-branch`
* Commit your changes: `git commit -am 'Some feature'`
* Push to your branch: `git push origin feature-branch`
* Create a Pull Request
