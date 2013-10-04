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

### Exhibit C.
    # (In Controller)
    profile, new_job_application = redis_lock(current_user, "attach_new") do
      return [
        ApplicantProfile.create(:phone_number => params[:phone], :user => user),
        JobApplication.create(:job => Job.find(params[:job_id]), :user => user)
      ]
    end
    render :json => {:saved => profile, :url => employer_portal_job_application_path(new_job_application)}.to_json