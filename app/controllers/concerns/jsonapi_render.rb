module JSONAPIRender
  extend ActiveSupport::Concern

  def render_collection(resources, status = 200, serializer: nil, **serializer_options)
    serializer_class = serializer || default_collection_seralizer_class(resources)
    render json: serializer_class.render(resources, serializer_options), status:
  end

  def render_resource(resource, status = 200, serializer: nil, **serializer_options)
    serializer_class = serializer || default_resource_seralizer_class(resource)
    render json: serializer_class.render(resource, serializer_options), status:
  end

  def render_errors(errors, status = nil)
    api_error = APIError::RecordInvalidError.new(errors)
    render json: api_error, status: status || api_error.status
  end

  private

  def default_collection_seralizer_class(resources)
    "#{resources.klass}Serializer".constantize
  end

  def default_resource_seralizer_class(resource)
    "#{resource.class}Serializer".constantize
  end
end
