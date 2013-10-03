module ActiveRecordRedisLock
  def redis_lock(ob, action_name, &blk)
    klass = ob.class.name
    caller = if ob.superclass == ActiveRecord::Base 
      ob.try(:id)
    else
      ob.to_s
    end

    Redis.current.lock("#{klass}.#{caller || 'anon'}.#{action_name}", life: 1) do 
      blk.call(self)
      # logger.debug("redis_locked called @ #{Time.now.to_i}") if debug
    end
  end
end

ActiveRecord::Base.extend(ActiveRecordRedisLock)
