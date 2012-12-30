class ShiftIssuesController < ApplicationController
	unloadable

	def index
		#@issues = Issue.find_all_by_id(params[:issue_ids]) unless not params[:issue_ids].nil? and not params[:issue_ids].empty?
		#if not params[:issue_ids].nil? and not params[:issue_ids].empty? and params[:issue_ids].size > 0 then
			@issues = Issue.find_all_by_id(params[:issue_ids])
		#else
		#	@issues = []
		#end
		@back_url = params[:back_url]
		@projects = @issues.collect(&:project).compact.uniq unless @issues.nil? and @issues.empty?
		@project = @projects.first if @projects.size == 1
	end

	def shift
		@issues = Issue.find_all_by_id(params[:issue_ids])
		@shift_type = Integer(params[:shift_type])
		@shift_days = Integer(params[:shift_days])
		@back_url = params[:back_url];

		#@projects = @issues.collect(&:project).compact.uniq
		#@project = @projects.first if @projects.size == 1

		# shift the issues
		@issues.each do |issue|
			# make sure that the issue is the latest issues
			issue.reload

			# set the history
			journal = issue.init_journal(User.current, "")

			hash_attr = Hash.new

			# set start date if it is set
			if not issue.start_date.nil? then
				hash_attr["start_date"] = (@shift_type == 1) ? (issue.start_date + @shift_days) : (issue.start_date - @shift_days)
			end

			# set end date if it is set
			if not issue.due_date.nil? then
				hash_attr["due_date"] = (@shift_type == 1) ? (issue.due_date + @shift_days) : (issue.due_date - @shift_days)
			end

			issue.safe_attributes = hash_attr

			# save issue
			issue.save
		end

		flash[:notice] = l(:notice_successful_update)

		redirect_back_or_default(@back_url)
	end

end
