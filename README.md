ActiveRecordRedisLock
=====================

### Exhibit A.
    Post:
      id: Int
      title: String
      body: String

    Post.redis_lock(current_user, "create_post") do
      create(title: "Blah", body: "Blah blah blah")
    end

### Exhibit B.
    Post.send_query([{joins: "user"}, {joins: {user: "info"}}])
