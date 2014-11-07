Redmine::Plugin.register :redmine_membersgmap do
	name 'Redmine Members Google Map plugin'
	author 'TriggerAu'
	description 'This plugin for Redmine adds a wiki macro that will generate a Google Map showing member locations based on a custom user field'
	version '0.0.1'
	url 'http://example.com/path/to/plugin'
	author_url 'http://example.com/about'

    Redmine::WikiFormatting::Macros.register do
  
		desc "Draw a Google Map that shows Project Users - Wiki Pages only" + "\n\n" +
			"  <pre>{{members_gmap}}</pre>" 
		macro :members_gmap do |obj, args|
		  
			args, argoptions = extract_macro_options(args, :roleorder, :height)

			Options = Struct.new(:height, :roleorder, :listinsidebar, :showdaylight, :centerlat, :centerlong, :zoominitial, :zoommin) 
			options = Options.new
			
			mapfieldname = args.first
			raise 'no mapfield name supplied' unless mapfieldname.present?

			mapfield = CustomField.select {|cfi|cfi.name == mapfieldname}[0]
			raise 'Cannot find customfield called ' + mapfieldname if mapfield.nil?

			################# Optional params #################
			#height
			options.height = argoptions[:height]
			raise 'Invalid size parameter' unless options.height.nil? || options.height.match(/^\d+$/)
			options.height = options.height.to_i
			options.height = 600 unless options.height > 0
			#role order
			options.roleorder = argoptions[:roleorder]
			options.roleorder = "Developer,Manager,Reporter" if options.roleorder.nil?
			#List Position order
			options.listinsidebar = argoptions[:listinsidebar]
			options.listinsidebar = false if options.listinsidebar.nil?
			#Show Daylight overlay
			options.showdaylight = argoptions[:showdaylight]
			options.showdaylight = false if options.showdaylight.nil?
			#Center Latitude
			options.centerlat = argoptions[:centerlat]
			options.centerlat = 10 if options.centerlat.nil?
			#Center Latitude
			options.centerlong = argoptions[:centerlong]
			options.centerlong = 20 if options.centerlong.nil?
			#Initial map zoom
			options.zoominitial = argoptions[:zoominitial]
			options.zoominitial = 2 if options.zoominitial.nil?
			#Minimum map zoom
			options.zoommin = argoptions[:zoommin]
			options.zoommin = 2 if options.zoommin.nil?
			################# / Optional params #################
			
			
			
			#Get the current project ID
			project_id = params[:project_id]
			project = Project.visible.find_by_identifier(project_id)
			raise 'Can\'t find the project' if project.nil?

			#Now get the list of users from the User Table
			userlist = User.active.find(:all, :conditions => ["#{User.table_name}.id IN (SELECT DISTINCT user_id FROM members WHERE project_id=(?))", project.id]).sort
			raise 'Can\'t find any users' if userlist.nil?

			#Send this off to be rendered
			render :partial => 'wiki/members_gmap', :locals => {:users => userlist, :project => project, :mapfield => mapfield, :options => options}
			#render :partial => 'wiki/members_gmap', :locals => {:users => userlist, :project => project, :roleorder => roleorder, :height => height}

		end  
	end
end
