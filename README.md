ActiveRecordRedisLock
=====================

### Exhibit A.
    Post:
      id: Int
      title: String
      body: String

    User:
      id: Int
      ...

    Post.redis_lock(current_user, "create_post") do |p|
      p.create(title: "Blah", body: "Blah blah blah")
    end
    
### Exhibit B.
    Post.redis_lock(current_user, "create_post") do
      Post.create(title: "Blah", body: "Blah blah blah")
    end
