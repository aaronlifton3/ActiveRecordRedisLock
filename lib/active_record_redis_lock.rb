require 'redis'
require 'redis-lock'
require 'mlanett-redis-lock'

module ActiveRecordRedisLock
  def redis_lock(user, action_name, &blk)
    Redis.current.lock("#{user.try(:id) || 'anon'}.#{action_name}", life: 1) 
      binding.pry
      blk.call(self)
      # logger.debug("redis_locked called @ #{Time.now.to_i}") if debug
    end
  end
end

ActiveRecord::Base.extend(ActiveRecordRedisLock)
