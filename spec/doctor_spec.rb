require("spec_helper")

describe(Doctor) do
  describe(".all") do
    it('starts of with no doctors') do
      expect(Doctor.all()).to(eq([]))
    end
  end

  describe("#name") do
    it("tells you its name") do
      doctor = Doctor.new({:name => "Brian", :specialty_id => 1, :id => nil})
      expect(doctor.name()).to(eq("Brian"))
    end
  end

  describe("#id") do
    it("sets its ID when you save it") do
      doctor = Doctor.new({:name => "Epicodus stuff", :specialty_id => 1, :id => nil})
      doctor.save()
      expect(doctor.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#save") do
    it("lets you save lists to the database") do
      doctor = Doctor.new({:name => "Epicodus stuff", :specialty_id => 1, :id => nil})
      doctor.save()
      expect(Doctor.all()).to(eq([doctor]))
    end
  end

  describe("#==") do
    it("is the same list if it has the same name") do
      doctor1 = Doctor.new({:name => "Epicodus stuff", :specialty_id => 1, :id => nil})
      doctor2 = Doctor.new({:name => "Epicodus stuff", :specialty_id => 1, :id => nil})
      expect(doctor1).to(eq(doctor2))
    end
  end

  describe(".find") do
    it("returns a list by its ID") do
      test_doctor = Doctor.new({:name => "Moringaschool stuff", :specialty_id => 1, :id => nil})
      test_doctor.save()
      test_doctor2 = Doctor.new({:name => "Home stuff", :specialty_id => 1, :id => nil})
      test_doctor2.save()
      expect(Doctor.find(test_doctor2.id())).to(eq(test_doctor2))
    end
  end

  describe("#tasks") do
    it("returns an array of tasks for that list") do
      test_doctor = Doctor.new({:name => "Moringaschool stuff", :specialty_id => 1, :id => nil})
      test_doctor.save()
      test_patient = Patient.new({:name => "Richard", :birthdate => '1992-3-7', :doctor_id => test_doctor.id()})
      test_patient.save()
      test_patient2 = Patient.new({:name => "Gabriel", :birthdate => '1992-3-7', :doctor_id => test_doctor.id()})
      test_patient2.save()
      expect(test_doctor.patients()).to(eq([test_patient, test_patient2]))
    end
  end


end
