module ExceptionHandler
  class InvalidEmail < StandardError; end # => Email not valid
  class MissingTable < StandardError; end # => No table present
end
