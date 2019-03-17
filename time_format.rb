module TimeFormat

  FORMATS = {
    'year' => '%Y',
    'month'  => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%H',
  }.freeze
  attr_reader :unknown_format, :time_format

  def bad_time_format?
    !@unknown_format.empty?
  end

  def set_format_time
    unless @format_time.empty?
      @time_format = ''
      @format_time.each { |format| @time_format += FORMATS[format] + '-' }
    end
  end


  def time_format(request_format)
    @format_time, @unknown_format = request_format.partition { |format| FORMATS.has_key?(format)}
  end
end
