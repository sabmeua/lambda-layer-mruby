class LambdaServer
  LAMBDA_SERVER_ADDRESS = "http://127.0.0.1:9001/2018-06-01"

  def initialize(server_address: LAMBDA_SERVER_ADDRESS)
    @server_address = server_address
  end

  def next_invocation
    next_invocation_uri = @server_address + "/runtime/invocation/next"
    begin
      http = HttpRequest.new
      resp = http.get(next_invocation_uri)
      if resp.code == 200
        request_id = resp.headers["Lambda-Runtime-Aws-Request-Id"]
        [request_id, resp]
      else
        raise LambdaErrors::InvocationError.new(
          "Received #{resp.code} when waiting for next invocation."
        )
      end
    rescue LambdaErrors::InvocationError => e
      raise e
    rescue StandardError => e
      raise LambdaErrors::InvocationError.new(e)
    end
  end

  def send_response(request_id:, response_object:, content_type:)
    response_uri = @server_address + "/runtime/invocation/#{request_id}/response"
    begin
      # unpack IO at this point
      if content_type == 'application/unknown'
        response_object = response_object.read
      end
      http = HttpRequest.new
      http.post(
        response_uri,
        response_object,
        {'Content-Type' => content_type}
      )
    rescue StandardError => e
      raise LambdaErrors::LambdaRuntimeError.new(e)
    end
  end

  def send_error_response(request_id:, error_object:, error:)
    response_uri = @server_address + "/runtime/invocation/#{request_id}/error"
    begin
      http = HttpRequest.new
      http.post(
        response_uri,
        error_object.to_json,
        { 'Lambda-Runtime-Function-Error-Type' => error.runtime_error_type }
      )
    rescue StandardError => e
      raise LambdaErrors::LambdaRuntimeError.new(e)
    end
  end

  def send_init_error(error_object:, error:)
    uri = @server_address + "/runtime/init/error"
    begin
      http = HttpRequest.new
      http.post(
        uri,
        error_object.to_json,
        {'Lambda-Runtime-Function-Error-Type' => error.runtime_error_type}
      )
    rescue StandardError
      raise LambdaErrors::LambdaRuntimeInitError.new(e)
    end
  end
end
