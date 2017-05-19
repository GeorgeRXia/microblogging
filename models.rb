class Blog < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy

end

class User < ActiveRecord::Base

  has_many :blogs, dependent: :destroy
  has_many :comments
<<<<<<< HEAD
<<<<<<< HEAD
end1
=======

end
>>>>>>> 54d15cfdfc1723700cc6c4bb0854320994d49581
=======
end
>>>>>>> sam

class Comment < ActiveRecord::Base
  belongs_to :blog
  belongs_to :user
end
