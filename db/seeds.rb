# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'json'
dataset=ARGV[1]
hash_data=JSON.parse(File.read(dataset))
jobs_counter=0

	def get_float_from_string(str)
		if str[',']
			str[',']=''
		end
		return str.match(/[.\d]+/)[0].to_f
	end

def add_organization_if_not_exist(model,name)
	if model.find_by_name(name)==nil
		new_record=model.new(:name => name)
		new_record.save
		return model.find_by_name(name).id
	else
		return model.find_by_name(name).id
	end
end

def add_agency_if_not_exist(model,name,organization_id)
	if model.find_by_name(name)==nil
		new_record=model.new(:name => name, :organization_id=>organization_id)

		new_record.save
		return model.find_by_name(name).id
	else
		return model.find_by_name(name).id
	end
end
puts "Please wait until your database population is done.."
hash_data.each do |h|
	#puts h.keys
	jobs_set=h['JobData']

	#puts jobs_set.length
	jobs_set.each do |j|

		organization_id=add_organization_if_not_exist(Organization,j['OrganizationName'])

		agency_id=add_agency_if_not_exist(Agency,j['AgencySubElement'],organization_id)

		if Job.find_by_DocumentID(j['DocumentID'])==nil
			job=Job.new()
			j.keys.each do |key|
				if key!='OrganizationName' && key!='AgencySubElement'
					#puts key
					value=j[key]
					if key=='SalaryMin' or key=='SalaryMax'
						#puts "+++++++++++++++"
						#puts value
						#puts "+++++++++++++++"
						value=get_float_from_string(value.to_s)

						#puts value
						#puts "+++++++++++++++"
					end
					job.send("#{key}=",value)
				end
			end
			job.organization_id=organization_id.to_i()
			job.agency_id=agency_id.to_i()
		
			job.save
		end
		jobs_counter+=1	
	end
end

'''
DocumentID
JobTitle
OrganizationName
AgencySubElement
SalaryMin
SalaryMax
SalaryBasis
StartDate
EndDate
WhoMayApplyText
PayPlan
Series
Grade
WorkSchedule
WorkType
Locations
AnnouncementNumber
JobSummary
ApplyOnlineURL
'''
