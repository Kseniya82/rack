require_relative 'time_format'
class App
  def call(env)
    request = Rack::Request.new(env)
    return bad_request if request.path != '/time'

    time_format = TimeFormat.new(request.params['format'].split(','))
    if time_format.bad_time_format?
      bad_format(time_format.unknown_format)
    else
      rigth_format(time_format.set_time)
    end
  end

  private

  def bad_request
    make_response(404, 'Path not foumd')
  end

  def bad_format(format)
    make_response(400, "Unknown time format #{format}")
  end

  def rigth_format(format)
    make_response(200, format)
  end

  def make_response(status, body)
      [status, headers = { 'content-type' => 'text-plain' }, ["#{body}\n"]]
  end
end
