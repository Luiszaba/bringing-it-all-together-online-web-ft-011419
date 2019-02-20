class Dog
  
  attr_accessor :name, :breed, :id
  
  
  def initialize(name:, breed:, id:nil)
    @name = name
    @breed = breed
    @id = id
  end
  
  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS dogs (
    id INTEGER PRIMARY KEY,
    name TEXT,
    breed TEXT
    )
    SQL
    DB[:conn].execute(sql)
  end
  
  def self.drop_table
    sql = <<-SQL
    DROP TABLE IF EXISTS dogs
    SQL
    DB[:conn].execute(sql)
  end
  
  def save
    if self.id
      self.update
    else 
      sql = <<-SQL
      INSERT INTO dogs (name, breed) VALUES (?,?)
      SQL
      DB[:conn].execute(sql, self.name, self.breed)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
    end
    self
  end
  
  def self.create(name:, breed:, id:nil)
    pet = Dog.new(name: name, breed: breed)
    pet.save
    pet
  end
  
  def self.new_from_db(row)
    id=[0]
    name=[1]
    breed=[2]
    new_dog = Dog.new([0], name, breed)
  
  def self.find_by_id(id)
    pet_sch = DB[:conn].execute(sql, self.id)[0]
end
self
end


    
    
    
    
    
    
  
  
