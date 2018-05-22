require 'active_admin'

module ActiveAdmin
  module JfuUpload
    class Engine < ::Rails::Engine
      engine_name 'activeadmin_jfu_upload'

      class << self
        def upload_file( request, param, resource, field )
          response = { result: 0 }
          if !param.blank?
            if request.headers['CONTENT-RANGE'].blank?
              resource.update field => param
              response = { result: 1, file_name: resource.try( field ).try( :url ) }
            else
              m = request.headers['CONTENT-RANGE'].match( /[^\s]+\s(\d+)-(\d+)\/(\d+)/ )
              if m
                buffer = param.read
                pos = m[1].to_i
                if pos == 0
                  tempfile = Rails.root.join('tmp', "upload_#{Time.now.to_i}_#{resource.id}_#{field}")
                  field_data = { original_filename: param.original_filename, tempfile: tempfile }
                  # dir.mkdir unless File.exists?(dir)
                  # field_data = { original_filename: param.original_filename, tempfile: dir.join(param.tempfile).to_s }  # alternative: "#{resource.class.to_s.tableize}_#{resource.id}_#{Time.now.to_i}"
                  resource.update_column field, YAML::dump( field_data )
                  mode = 'wb'
                else
                  field_data = YAML::load resource.read_attribute(field)
                  mode = 'ab'
                end
                File.open(field_data[:tempfile], mode) { |f| f.write(buffer) }
                if ( m[2].to_i + 1 ) == m[3].to_i
                  path = Pathname.new field_data[:tempfile]
                  dst = path.dirname.join(field_data[:original_filename]).to_s
                  File.rename(field_data[:tempfile], dst)
                  resource.send("#{field}=", File.open(dst))
                  resource.save
                  response = { result: 1, pos: m[3].to_i, file_name: resource.try(field).try(:url) }
                else
                  response = { result: 2, position: pos }
                end
              end
            end
          end
          response
        end
      end
    end
  end
end
