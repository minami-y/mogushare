class ErrorsController < ActionController::Base
  layout 'application'

  rescue_from Exception, with: :render_500
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404

  def render_404(exception = nil)
    if exception
      logger.info "Rendering 404 with exception: #{exception.message}"
    end
    render template: "errors/404", status: 404, layout: 'application'
  end

  def render_500(exception = nil)
    if exception
      logger.info "Rendering 500 with exception: #{exception.message}"
    end
    render template: "errors/500", status: 500, layout: 'application'
  end

  def show; raise env["action_dispatch.exception"]; end
end

