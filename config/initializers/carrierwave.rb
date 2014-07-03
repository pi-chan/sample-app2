if Rails.env.production?
  
else
  CarrierWave.configure do |config|
    config.storage = :file
  end
end
