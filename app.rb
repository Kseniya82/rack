require_relative 'time_format'
class App
  include TimeFormat
  def call(env)
    @query_string = env['QUERY_STRING']
    @request_path = env['REQUEST_PATH']
    time_format(request_format)
    [status, header, body]
  end

  private

  def status
    return 404 if @request_path != '/time'
    return 400 if bad_time_format?
    200
  end

  def header
    { 'content-type' => 'text-plain' }
  end

  def body
    return ["Path not foumd\n"] if @request_path != '/time'
    if bad_time_format?
      ["Unknown time format #{@unknown_format}\n"]
    else
      set_format_time
      [Time.now.strftime(@time_format) + "\n"]
    end
  end

  private

  def request_format
    @query_string.partition("format=").last.split("%2C")
  end
end
