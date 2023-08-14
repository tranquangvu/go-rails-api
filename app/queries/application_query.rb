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
  class_attribute :single_query_scope
  attr_reader :scope

  class << self
    def call(scope = nil, ...)
      new(scope).call(...)
    end

    def single_query_on(sqscope)
      self.single_query_scope = sqscope.is_a?(String) ? sqscope.constantize : sqscope
    end
  end

  def initialize(scope = nil)
    @scope = scope || self.class.single_query_scope
  end

  def call
    raise NotImplementedError, "You must define `call` as instance method in #{self.class.name} class."
  end
end
