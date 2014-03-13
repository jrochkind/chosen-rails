# Chosen for rails asset pipeline

[Chosen](https://github.com/harvesthq/chosen) is a library for making long, unwieldy select boxes more user friendly.

The `chosen_assets` gem integrates the `Chosen` with the Rails asset pipeline.

**This is a fork of [chosen-rails](https://github.com/tsechingho/chosen-rails)**, this gem, `chosen_assets`, gets
already compiled .js and .css from the original chosen Github release (via the github api),
and thus has no dependencies on compass (or sass or coffeescript), it just gives you the already
compiled source. 

## Usage

### Install chosen_assets gem

Include `chosen_assets` in Gemefile

    gem 'chosen_assets'

Then run `bundle install`

### Include chosen javascript assets

Add to your `app/assets/javascripts/application.js` if use with jQuery

    //= require chosen.jquery

Or with Prototype

    //= require chosen.prototype

### Include chosen stylesheet assets

Add to your `app/assets/stylesheets/application.css`

    *= require chosen

### Enable chosen javascript by specific css class

Add to one coffee script file, like `scaffold.js.coffee`

    $ ->
      # enable chosen js
      $('.chosen-select').chosen
        allow_single_deselect: true
        no_results_text: 'No results matched'
        width: '200px'

Notice: `width` option is required since `Chosen 0.9.15`.

And this file must be included in `application.js`

    //= require chosen.jquery
    //= require scaffold

Also add the class to your form field

    <%= f.select :author,
      User.all.map { |u| [u.name, u.id] },
      { include_blank: true },
      { class: 'chosen-select' }
    %>

If you use simple form as form builder

    <%= f.association :author,
      collection: User.all,
      include_blank: true,
      input_html: { class: 'chosen-select' }
    %>


## Gem maintenance

### Update chosen source in `chosen_assets` gem with `Rake` commands.

Update origin chosen source files.

    rake update-chosen

That will look for the latest release from chosen's github, download the
release zip, and copy assets into source. For css files, it also replaces
any url() references to use rails-sass asset-url(). 

If chosen is out of date, feel free to do this and make a pull request! 

Versioning for `chosen_assets` tracks chosen version -- `chosen_assets 1.1.0.0`
uses chosen `1.1.0`, and is the first `chosen_assets` release of that chosen version. 

### Publish gem.

    rake release

## License

use MIT license.
