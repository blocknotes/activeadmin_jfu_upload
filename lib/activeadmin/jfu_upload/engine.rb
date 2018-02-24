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
                  resource.update field => param
                else
                  File.open( resource.try( field ).try( :path ), 'ab' ) { |f| f.write( param.read ) }
                end
                if ( m[2].to_i + 1 ) == m[3].to_i
                  response = { result: 1, pos: m[3].to_i, file_name: resource.try( field ).try( :url ) }
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
