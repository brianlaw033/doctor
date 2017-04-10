require("spec_helper")


describe(Patient) do
  describe(".all") do
    it("is empty at first") do
      expect(Patient.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("adds a patient to the array of saved patients") do
      test_patient = Patient.new({:name => "learn SQL", :birthdate => '1994-9-11', :doctor_id => 1})
      test_patient.save()
      expect(Patient.all()).to(eq([test_patient]))
    end
  end

  describe("#description") do
    it("lets you read the description out") do
      test_patient = Patient.new({:name => "learn SQL", :birthdate => '1994-9-11', :doctor_id => 1})
      expect(test_patient.name()).to(eq("learn SQL"))
    end
  end

  describe("#doctor_id") do
    it("lets you read the doctor ID out") do
      test_patient = Patient.new({:name => "learn SQL", :birthdate => '1994-9-11', :doctor_id => 1})
      expect(test_patient.doctor_id()).to(eq(1))
    end
  end

  describe("#==") do
    it("is the same patient if it has the same description and doctor ID") do
      patient1 = Patient.new({:name => "learn SQL", :birthdate => '1994-9-11', :doctor_id => 1})
      patient2 = Patient.new({:name => "learn SQL", :birthdate => '1994-9-11', :doctor_id => 1})
      expect(patient1).to(eq(patient2))
    end
  end
end
