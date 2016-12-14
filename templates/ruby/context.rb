require 'singleton'
class Context
  include Singleton

  attr_accessor :driver
  attr_accessor :wait

  def initialize
    @driver = nil
    @wait = nil
  end
end
