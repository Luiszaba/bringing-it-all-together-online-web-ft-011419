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
    new_dog = Dog.new(id: row[0], name: row[1], breed: row[2])
  end
  
  def self.find_by_id(id)
    find_id = DB[:conn].execute("SELECT * FROM dogs WHERE id = ?", id)[0]
    self.new_from_db(find_id)
  end
  
  def self.find_by_name(name)
    find_name = DB[:conn].execute("SELECT * FROM dogs WHERE name = ?", name)[0]
    self.new_from_db(find_name)
  end
  
  def update
    sql =<<-SQL 
    UPDATE dogs SET name = ?, breed = ? WHERE id = ? 
    SQL
    DB[:conn].execute(sql, self.name, self.breed, self.id)
  end
  
  def self.find_or_create_by(name:, breed:)
     def self.find_or_create_by(name:, breed:)
    pet = DB[:conn].execute("SELECT * FROM dogs WHERE name = ? AND breed = ?", name, breed)
    if !pet.empty?
      new_pet = pet[0]
      pet = self.new(name: new_pet[1], breed: new_pet[2], id: new_pet[0])
    else
      pet = self.create(name: name, breed: breed)
    end
    pet
  end
end
end
    
    
    
  
  
