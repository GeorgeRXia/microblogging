class Blog < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
end

class User < ActiveRecord::Base
  has_many :blogs, dependent: :destroy
  has_many :comments
  has_many :favoriteblogs, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :friends, dependent: :destroy

end

class Comment < ActiveRecord::Base
  belongs_to :blog
  belongs_to :user
end

class Favoriteblog < ActiveRecord::Base
  belongs_to :user
end


class Request < ActiveRecord::Base
belongs_to :user
end

class Friend < ActiveRecord::Base
belongs_to :user, dependent: :destroy
end
