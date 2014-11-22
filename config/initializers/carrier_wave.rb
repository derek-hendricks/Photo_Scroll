if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
        :provider                         => 'Google',
        :google_storage_access_key_id => ENV['ACCESS_KEY'],
        :google_storage_secret_access_key =>  ENV['SECRET_KEY']
    }
    config.fog_directory = 'myphotosdh7'
end
end

