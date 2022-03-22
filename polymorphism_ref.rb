class Search
  def search(type)
    case type
    when :job
      search_jobs
    when :user 
      search_users
    else
      raise 'Unknown search type'
    end
  end
end

#####

# With inheritance:

class Base
  def search
    raise NoMethodError
  end
end

class Job < Base
  def search
    # search jobs
  end
end

class User < Base
  def search
    # search users
  end
end

[Job.new, User.new].map!(&:search)

#####

# With dynamic typing:

class Base
  def search(receiver)
    receiver.search
  end
end


class Job
  def search
    # search jobs
  end
end

class User
  def search
    # search users
  end
end

base = Base.new

[Job.new, User.new].map! { base.search(_1) }

