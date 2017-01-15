class CreateErrors < ActiveRecord::Migration[5.0]

  # => ATTRS
  require_relative "../../app/models/exception_handler/exception.rb"

  #########################################
  #########################################

    # => Defs
    @@table = ExceptionHandler.config.try(:db)

  #########################################

    # Up
    def up
      create_table @@table do |t|
        ExceptionHandler::ATTRS.each do |attr|
          t.text attr
        end
        t.timestamps
      end
    end

  #########################################

    # Down
    def down
      drop_table @@table, if_exists: true
    end

  #########################################
  #########################################

end
