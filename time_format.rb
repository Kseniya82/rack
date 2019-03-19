class TimeFormat
  FORMATS = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%H'
  }.freeze

  attr_reader :unknown_format

  def initialize(request_format)
    time_format(request_format)
  end

  def set_time
    Time.now.strftime(set_format_time) unless @format_time.empty?
  end

  def bad_time_format?
    !@unknown_format.empty?
  end

  private

  def set_format_time
    @format_time.map { |format| FORMATS[format] }.join("-")
  end

  def time_format(request_format)
    @format_time, @unknown_format = request_format.partition { |format| FORMATS.include?(format)}
  end
end
