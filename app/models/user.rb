class User < Neo4j::Rails::Model
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :patronymic, :email, :password, :remember_me

  property :first_name
  index :first_name

  property :last_name
  index :last_name

  property :patronymic
  index :patronymic

  property :email
  index :email

  validates :email, :uniqueness => true

end
