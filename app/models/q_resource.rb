class QResource < Neo4j::Rails::Model
  property :title, :type => String
  index :title, :type => :fulltext

  property :description, :type => String
  index :description, :type => :fulltext

  property :body, :type => String
  index :body, :type => :fulltext

  property :position, :type => Fixnum
  index :position

  property :url, :type => String
  index :url

  property :note, :type => String
  index :note, :type => :fulltext

  property :isource, :type => String
  index :isource, :type => :fulltext

  property :created_at, :type => DateTime
  index :created_at

  property :updated_at, :type => DateTime
  index :updated_at

  property :bfile, :type => String
  mount_uploader :bfile, BinfileUploader
end
