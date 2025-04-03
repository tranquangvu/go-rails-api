# Usage: read more at https://thoughtbot.com/blog/a-case-for-query-objects-in-rails

module Scopeable
  extend ActiveSupport::Concern

  class_methods do
    def scope(name, body)
      define_method name do |*args, **kwargs|
        relation = instance_exec(*args, **kwargs, &body)
        relation || self
      end
    end
  end
end

class ApplicationQuery
  attr_reader :scope

  def self.call(scope = nil, ...)
    new(scope).call(...)
  end

  def initialize(scope = nil)
    @scope = scope
  end

  def call
    raise NotImplementedError, "You must define `call` as instance method in #{self.class.name} class."
  end
end
