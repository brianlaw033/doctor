class Specialty

attr_reader(:name, :id)

def initialize(attributes)
  @name = attributes.fetch(:name)
  @id = attributes.fetch(:id)
end

def self.all()
  returned_specialties = DB.exec('SELECT * FROM specialties;')
  specialties = []
  returned_specialties.each do |specialty|
    name = specialty.fetch('name')
    id = Integer(specialty.fetch('id'))
    specialties.push(Specialty.new({:name => name, :id => id}))
  end
  specialties
end

def save()
  result = DB.exec("INSERT INTO specialties (name) VALUES ('#{@name}') RETURNING id;")
  @id = Integer(result.first.fetch('id'))
end

def self.find(id)
  found_specialty = nil
  Specialty.all().each do |specialty|
    if specialty.id == id
      found_specialty = specialty
    end
  end
  found_specialty
end

def doctors()
  specialty_doctor = []
  doctors =  DB.exec("SELECT * FROM doctors WHERE specialty_id = #{self.id};")
  doctors.each do |doctor|
    name = doctor.fetch('name')
    specialty_id = doctor.fetch('specialty_id')
    id = doctor.fetch('id')
    specialty_doctor.push(Doctor.new({:name => name, :specialty_id => specialty_id, :id => id}))
  end
  specialty_doctor
end
end
