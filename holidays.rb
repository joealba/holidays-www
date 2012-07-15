require 'sinatra'
require 'haml'
require 'holidays'
require 'chronic'

Holidays.load_all

get '/' do
  if params[:date]
    date = Chronic.parse(params[:date])
    if !date
      @error = "Sorry, I could not parse the date you entered."
    end
  end
  date ||= Date.today

  @when = date.strftime('%B %-d, %Y')
  @holidays = Holidays.on(date, :any)
  haml :index, :format => :html5
end