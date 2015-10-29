$redis = Redis.new(url: ENV["REDIS_URL"].presence || 'redis://127.0.0.1/0')
