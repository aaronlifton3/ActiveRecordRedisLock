require 'redis'
require 'redis-lock'
require 'mlanett-redis-lock'

module ActiveRecordRedisLock
  def redis_lock(user, action_name, &blk)
    Redis.current.lock("#{user.try(:id) || 'anon'}.#{action_name}") do
      binding.pry
      if super
        blk.call super
      else
        blk.call
      end
      # logger.debug("redis_locked called @ #{Time.now.to_i}") if debug
    end
  end
end

ActiveRecord::Base.extend(ActiveRecordRedisLock)
