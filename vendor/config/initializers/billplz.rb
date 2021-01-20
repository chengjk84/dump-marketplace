Billplz.configure do |config|
  if Rails.env.production?
    config.api_key = ENV['BILLPLZ_API_KEY']
  else
    config.api_key = 'c7af3084-4f4b-41ce-bc58-db58f6e14e9b'
  end
end
