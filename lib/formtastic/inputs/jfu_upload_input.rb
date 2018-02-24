module Formtastic
  module Inputs
    class JfuUploadInput < Formtastic::Inputs::FileInput
      def input_html_options
        super.merge( class: 'jfu_upload_input' )
      end

      def to_html
        input_wrapping do
          label_html <<
          template.content_tag( :div, { class: 'jfu_upload_wrapper' } ) do
            builder.file_field( method, input_html_options ) <<
            template.content_tag( :ul )
          end
        end
      end
    end
  end
end
