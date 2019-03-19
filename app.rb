require_relative 'time_format'
class App
  def call(env)
    request = Rack::Request.new(env)
    @format = request.params['format']
    @request_path = request.path
    @time_format = TimeFormat.new(request_format)
    make_response
  end

  private

  def status
    return 404 if @request_path != '/time'
    return 400 if @time_format.bad_time_format?
    200
  end

  def make_response
    headers = { 'content-type' => 'text-plain' }
    [status, headers, ["#{body}\n"]]
  end

  def body
    return 'Path not foumd' if @request_path != '/time'
    if @time_format.bad_time_format?
      "Unknown time format #{@time_format.unknown_format}"
    else
      @time_format.set_time
    end
  end

  private

  def request_format
    @format.split(',')
  end
end
