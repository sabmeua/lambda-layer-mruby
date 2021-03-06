class LambdaLogger
  class << self
    def log_error(exception:, message: nil)
      STDERR.puts message if message
      STDERR.puts JSON.pretty_generate(exception.to_lambda_response)
    end
  end
end
