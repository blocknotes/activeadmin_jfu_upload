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
                pos = m[1].to_i
                if pos == 0
                  # resource.update field => param
                  dir = Rails.root.join('tmp', 'uploads')
                  dir.mkdir unless File.exists?(dir)
                  @@last_filename = param.original_filename  # TODO: fix me!
                  resource.update_column field, dir.join(param.tempfile).to_s  # alternative: "#{resource.class.to_s.tableize}_#{resource.id}_#{Time.now.to_i}"
                  # else
                  #   File.open( resource.try( field ).try( :path ), 'ab' ) { |f| f.write( param.read ) }
                end
                File.open(resource.read_attribute(field), 'ab') { |f| f.write(param.read) }
                if ( m[2].to_i + 1 ) == m[3].to_i
                  file = resource.read_attribute(field)
                  path = Pathname.new file
                  dst = path.dirname.join(@@last_filename).to_s
                  File.rename(file, dst)
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
