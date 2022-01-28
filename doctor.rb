require 'sqlite3'
DB = SQLite3::Database.new("db/doctors.db")

class Doctor
  attr_reader :id

  def initialize(attributes = {})
    # Is there a way we could accept symbols AND strings as keys?
    @id = attributes[:id]
    @name = attributes[:name]
    @age = attributes[:age]
    @specialty = attributes[:specialty]
  end

  def save
    # if you're creating a doctor
    query = "INSERT INTO doctors (name, age, specialty) VALUES (?, ?, ?)"
    DB.execute(query, @name, @age, @specialty)
    @id = DB.last_insert_row_id
    # if you're updating a doctor
    # ...
  end

  def self.all
    DB.results_as_hash = true
    DB.execute('SELECT * FROM doctors')
    # turn these hashes into instances (notice the keys' data type)
  end
end

# p Doctor.all
# david = Doctor.new(
#   name: 'David',
#   age: 30,
#   specialty: 'Urology'
# )
# p david.save
