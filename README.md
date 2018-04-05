# ActiveAdmin jQuery-File-Upload [![Gem Version](https://badge.fury.io/rb/activeadmin_jfu_upload.svg)](https://badge.fury.io/rb/activeadmin_jfu_upload)

An ActiveAdmin plugin to use [jQuery-File-Upload](https://github.com/blueimp/jQuery-File-Upload) for file uploads in forms.

Features:
- AJAX uploads
- chunked file uploads for large files

The file is uploaded when selected, not when the form is submitted, that's why a record must exist for uploads.

## Install

- Update your Gemfile: `gem 'activeadmin_jfu_upload'` (and execute *bundle*)
- Add at the end of your ActiveAdmin styles (_app/assets/stylesheets/active_admin.scss_):
```css
@import 'activeadmin/jfu_upload_input';
```
- Add at the end of your ActiveAdmin javascripts (_app/assets/javascripts/active_admin.js_):
```js
//= require activeadmin/jfu_upload/jquery.fileupload.js
//= require activeadmin/jfu_upload_input
```
- Use the input with `as: :jfu_upload` in Active Admin model conf

Why 2 separated scripts? In this way you can include a different version of *jQuery-File-Upload* if you like.

## Options

**data-options**: permits to set *jQuery-File-Upload* options directly - see [options list](https://github.com/blueimp/jQuery-File-Upload/wiki/Options)

## Examples

```ruby
# ActiveAdmin article form conf:
  form do |f|
    f.inputs 'Article' do
      f.input :title
      # Field setup - data url is required
      f.input :cover, as: :jfu_upload, hint: f.object.cover? ? image_tag( f.object.cover.url ) : '', input_html: { data: { url: jfu_upload_admin_article_path( resource.id ) } } unless f.object.new_record?
      f.input :published
    end
    f.actions
  end

  # Upload action - an helper method is provided
  member_action :jfu_upload, method: [:patch] do
    render json: ActiveAdmin::JfuUpload::Engine::upload_file( request, params[:article][:cover], resource, :cover )
  end
```

```ruby
# Chuncked upload (chunk size: 100 Kb)
f.input :cover, as: :jfu_upload, hint: f.object.cover? ? image_tag( f.object.cover.url ) : '', input_html: { data: { url: jfu_upload_admin_article_path( resource.id ), options: { maxChunkSize: 100000 } } } unless f.object.new_record?
```

## Notes

- The string field for the upload is used to store temp data, so it could be necessary to make it bigger

- If you want to customize the upload action take a look [here](lib/activeadmin/jfu_upload/engine.rb)

- Tested only with CarrierWave uploader gem

## Do you like it? Star it!

If you use this component just star it. A developer is more motivated to improve a project when there is some interest.

Take a look at [other ActiveAdmin components](https://github.com/blocknotes?utf8=✓&tab=repositories&q=activeadmin&type=source) that I made if you are curious.

## Contributors

- [Mattia Roccoberton](http://blocknot.es) - creator, maintainer

## License

[MIT](LICENSE.txt)
