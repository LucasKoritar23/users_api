class Db

  def initialize
    @bd = SQLite3::Database.new( "db/development.sqlite3" )
  end


  def select(query)
    @bd.execute(" #{query} ")
  end
end
