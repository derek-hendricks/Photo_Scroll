if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Configuration for Amazon S3
      :provider              => 'AWS',
      :aws_access_key_id     => ENV['S3_ACCESS_KEY'],
      :aws_secret_access_key => ENV['S3_SECRET_KEY'],
      :region                 => 'us-east-1',
      :endpoint               => 'photoderek.s3-website-us-east-1.amazonaws.com'
    }
 
  end
end
