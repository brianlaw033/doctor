require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a new doctor', {:type => :feature}) do
  it('allows a user to click a doctor to see the patients and details for it') do
    visit('/')
    click_link('Add New Doctor')
    fill_in('name', :with =>'Moringaschool Work')
    fill_in('specialty_id', :with => 1)
    click_button('Add Doctor')
    expect(page).to have_content('Success!')
  end
end

describe('viewing all of the doctors', {:type => :feature}) do
  it('allows a user to see all of the doctors that have been created') do
    doctor = Doctor.new({:name => 'Moringaschool Homework', :specialty_id => 1, :id => nil})
    doctor.save()
    visit('/')
    click_link('View All Doctors')
    expect(page).to have_content(doctor.name)
  end
end

describe('seeing details for a single doctor', {:type => :feature}) do
  it('allows a user to click a doctor to see the patients and details for it') do
    test_doctor = Doctor.new({:name => 'School stuff', :specialty_id => '1', :id => nil})
    test_doctor.save()
    test_patient = Patient.new({:name => "learn SQL", :birthdate => "1992-2-8", :doctor_id => test_doctor.id()})
    test_patient.save()
    visit('/doctors')
    click_link(test_doctor.name())
    expect(page).to have_content(test_patient.name())
  end
end

describe('adding patients to a doctor', {:type => :feature}) do
  it('allows a user to add a patient to a doctor') do
    test_doctor = Doctor.new({:name => 'School stuff', :specialty_id => '1', :id => nil})
    test_doctor.save()
    visit("/doctors/#{test_doctor.id()}")
    fill_in("name", {:with => "Learn SQL"})
    fill_in('birthdate', {:with => '1993-3-3'})
    click_button("Add patient")
    expect(page).to have_content("Success")
  end
end
