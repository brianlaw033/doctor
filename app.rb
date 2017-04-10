require('sinatra')
require('sinatra/reloader')
require('./lib/patient')
require('./lib/doctor')
require('./lib/specialty')
also_reload('lib/**/*.rb')
require("pg")

DB = PG.connect({:dbname => "doctor_office"})


get("/") do
  @specialties = Specialty.all()
  erb(:index)
end

post("/doctors") do
  name = params.fetch("name")
  specialty = params.fetch('specialty_id')
  doctor = Doctor.new({:name => name,:specialty_id => specialty, :id => nil})
  doctor.save()
  erb(:success)
end

get('/doctors') do
  @doctors = Doctor.all()
  erb(:doctors)
end

get("/specialties/:id") do
  @specialty = Specialty.find(params.fetch("id").to_i())
  erb(:specialty)
end

get("/specialties/doctor/:id") do
  @doctor = Doctor.find(params.fetch("id").to_i())
  erb(:doctor)
end

post("/patients") do
  name = params.fetch("name")
  birthdate = params.fetch('birthdate')
  doctor_id = params.fetch("doctor_id").to_i()
  @doctor = Doctor.find(doctor_id)
  @patient = Patient.new({:name => name, :birthdate => birthdate, :doctor_id => doctor_id})
  @patient.save()
  erb(:success)
end
