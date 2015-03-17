#Rails cast search example
#http://railscasts.com/episodes/37-simple-search-form

class JobsController < ApplicationController
	
	def index
		#generate quey based on the given parameters (join or not join`)
		def gen_query(type)
			if type=="simple"
				pref=""
			elsif type=="join"
				pref="jobs."
			end
			query="jobs.JobTitle like ? 
			and "+pref+"JobSummary like ? 
			and "+pref+"Locations like ? 
			and "+pref+"SalaryMin >= ? 
			and "+pref+"SalaryMax <= ? 
			and "+pref+"SalaryBasis like ? 
			and "+pref+"WhoMayApplyText like ? 
			and "+pref+"WorkType like ? 
			and "+pref+"WorkSchedule like ? 
			and "+pref+"PayPlan like ?"
		return query.to_s()
	end

	#a search query is done
	if params[:search]=="1"
		@alert=""
		#set the max salary to 100000000 if it was not precised by the user
		if params[:SalaryMax].to_f==0
			params[:SalaryMax]=100000000
		end
		#define a list of parameters that are used in all types of queries
		standard_params=["%#{params[:JobTitle]}%",
						"%#{params[:JobSummary]}%",
						"%#{params[:Locations]}%",
						params[:SalaryMin].to_f,
						params[:SalaryMax].to_f,
						"%#{params[:SalaryBasis]}%",
						"%#{params[:WhoMayApplyText]}%",
						"%#{params[:WorkType]}%",
						"%#{params[:WorkSchedule]}%",
						"%#{params[:PayPlan]}%"]
		#use orgnaization name and agency as search criterias
		if params[:OrganizationName]!="" and params[:AgencySubElement]!=""
			@query="organizations.name like ? and agencies.name like ? and "+gen_query("join")
			@found_oraganization_agency_jobs=Organization.includes(agencies: :jobs).all.where(
				[@query,"%#{params[:OrganizationName]}%","%#{params[:AgencySubElement]}%"]+standard_params).references(:agencies)
			@jobs_count=0
			@agencies_count=0
			@found_oraganization_agency_jobs.each do |org|
				org.agencies.each do |agency|
					@agencies_count+=1
					agency.jobs.each do |job|
						@jobs_count+=1
					end
				end
			end
		#use OrganizationName as search criteria
		elsif params[:OrganizationName]!=""
			@query="organizations.name like ? and "+gen_query("join")
			@found_oraganization_jobs=Organization.includes(agencies: :jobs).all.where(
				[@query,"%#{params[:OrganizationName]}%"]+standard_params).references(:agencies)
			@jobs_count=0
			@agencies_count=0
			@found_oraganization_jobs.each do |org|
				org.agencies.each do |agency|
					@agencies_count+=1
					agency.jobs.each do |job|
						@jobs_count+=1
					end
				end
			end
		#use AgencySubElement as search criteria
		elsif params[:AgencySubElement]!="" and params[:OrganizationName]==""
			@query="agencies.name like ? and "+gen_query("join")
			@found_agency_jobs=Agency.includes(:jobs).all.where(
				[@query,"%#{params[:AgencySubElement]}%"]+standard_params).references(:jobs)
			@jobs_count=0
			@agencies_count=0
			@found_agency_jobs.each do |agency|
				@agencies_count+=1
				agency.jobs.each do |job|
					@jobs_count+=1
				end
			end
		#only jobs details are used as search criterias 
		else
			@jobs=Job.where([gen_query("simple")]+standard_params)
		end
	elsif params[:search]=="0"
		@alert="No search performed, One or more search criteria have to be precised."
	end
end

def search
	if params[:JobTitle]=="" and params[:JobSummary]=="" and  params[:Locations]=="" and params[:SalaryMin]=="" and params[:SalaryMax]=="" and params[:SalaryBasis]=="" and params[:WorkType]=="" and params[:WorkSchedule]=="" and params[:PayPlan]=="" and params[:OrganizationName]=="" and params[:AgencySubElement]=="" and params[:WhoMayApplyText]==""
		redirect_to :controller => 'jobs', 
  	  				:action => 'index', 
  					:search => 0
  	else
  		redirect_to :controller => 'jobs', 
  	  				:action => 'index', 
  					:search => 1, 
  					:JobTitle => params[:JobTitle],
  					:JobSummary => params[:JobSummary],
  					:Locations => params[:Locations],
  					:SalaryMin => params[:SalaryMin],
  					:SalaryMax => params[:SalaryMax],
  					:SalaryBasis =>params[:SalaryBasis],
  					:WhoMayApplyText =>params[:WhoMayApplyText],
  					:WorkType =>params[:WorkType],
  					:WorkSchedule =>params[:WorkSchedule],
  					:PayPlan => params[:PayPlan],
  					:OrganizationName => params[:OrganizationName],
  					:AgencySubElement => params[:AgencySubElement]
  				end
  		end

end