def handler(event)
  { statusCode: 200, body: JSON.generate('Hello from Lambda!') }
end
