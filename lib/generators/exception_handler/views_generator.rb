module ExceptionHandler
  class ViewsGenerator < Rails::Generators::Base

    ###########################################
    ###########################################
    ###########################################

    #Views
    VIEWS = %w(views controllers models assets)

    #Options
    class_option :files, aliases: "-v", default: VIEWS, type: :array, desc: "Select file types (views, models, controllers, assets)"

    #Needed to reference files
    source_root File.expand_path("../../../../app", __FILE__)

    ###########################################
    ###########################################
    ###########################################

      #Files
      def create_files
        options.files.each do |arg|
          directory arg, "app/#{arg}"
        end
      end

    ###########################################
    ###########################################
    ###########################################

  end
end
