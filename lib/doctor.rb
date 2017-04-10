class Doctor

  attr_reader(:name, :specialty, :id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @specialty_id = attributes.fetch(:specialty_id)
    @id = attributes.fetch(:id)
  end

  def self.all()
    returned_doctors = DB.exec("SELECT * FROM doctors ORDER BY name ASC;")
    doctors = []
    returned_doctors.each do |doctor|
      name = doctor.fetch("name")
      specialty_id = Integer(doctor.fetch("specialty_id"))
      id = Integer(doctor.fetch('id'))
      doctors.push(Doctor.new({:name => name, :specialty_id => specialty_id, :id => id}))
    end
    doctors
  end

  def save()
    result = DB.exec("INSERT INTO doctors (name, specialty_id) VALUES ('#{@name}', '#{@specialty_id}') RETURNING id;")
    @id = Integer(result.first.fetch('id'))
  end

  def self.find(id)
    found_doctor = nil
    Doctor.all().each do |doctor|
      if doctor.id == id
        found_doctor = doctor
      end
    end
    found_doctor
  end

  def patients()
    doctor_patients = []
    patients = DB.exec("SELECT * FROM patients WHERE doctor_id = #{self.id};")
    patients.each do |patient|
      name = patient.fetch('name')
      birthdate = patient.fetch('birthdate')
      doctor_id = Integer(patient.fetch('doctor_id'))
      doctor_patients.push(Patient.new({:name => name, :birthdate => birthdate, :doctor_id =>doctor_id}))
    end
    doctor_patients
  end

  define_method(:==) do |another_doctor|
    self.name().==(another_doctor.name()).&(self.id().==(another_doctor.id()))
  end

end
