class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :DocumentID
      t.string :JobTitle
      t.float :SalaryMin
      t.float :SalaryMax
      t.string :SalaryBasis
      t.string :StartDate
      t.string :EndDate
      t.text :WhoMayApplyText
      t.string :PayPlan
      t.string :Series
      t.string :Grade
      t.string :WorkSchedule
      t.string :WorkType
      t.string :Locations
      t.integer :AnnouncementNumber
      t.text :JobSummary
      t.string :ApplyOnlineURL

      t.integer :organization_id
      t.integer :agency_id

      t.timestamps null: false
    end
  end
end
