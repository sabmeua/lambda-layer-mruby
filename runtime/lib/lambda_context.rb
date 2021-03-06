class LambdaContext
  attr_reader :aws_request_id, :invoked_function_arn, :log_group_name,
    :log_stream_name, :function_name, :memory_limit_in_mb, :function_version,
    :identity, :client_context, :deadline_ms

  def initialize(request)
    @deadline_ms = request['Lambda-Runtime-Deadline-Ms'].to_i
    @aws_request_id = request['Lambda-Runtime-Aws-Request-Id']
    @invoked_function_arn = request['Lambda-Runtime-Invoked-Function-Arn']
    @log_group_name = ENV['AWS_LAMBDA_LOG_GROUP_NAME']
    @log_stream_name = ENV['AWS_LAMBDA_LOG_STREAM_NAME']
    @function_name = ENV["AWS_LAMBDA_FUNCTION_NAME"]
    @memory_limit_in_mb = ENV['AWS_LAMBDA_FUNCTION_MEMORY_SIZE']
    @function_version = ENV['AWS_LAMBDA_FUNCTION_VERSION']
    if request['Lambda-Runtime-Cognito-Identity']
      @identity = JSON.parse(request['Lambda-Runtime-Cognito-Identity'])
    end
    if request['Lambda-Runtime-Client-Context']
      @client_context = JSON.parse(request['Lambda-Runtime-Client-Context'])
    end
  end
end
