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
	  
	  args, options = extract_macro_options(args, :roleorder, :height)

	  #height
	  height = options[:height]
      raise 'Invalid size parameter' unless height.nil? || height.match(/^\d+$/)
      height = height.to_i
      height = 400 unless height > 0
	  
	  #role order
	  roleorder = options[:roleorder]
	  roleorder = "Developer,Manager,Reporter" if roleorder.nil?
	  
	  #Get the current project ID
	  project_id = params[:project_id]
	  project = Project.visible.find_by_identifier(project_id)
      return 'Can\'t find the project' if project.nil?

	  #Now get the list of users from the User Table
      userlist = User.active.find(:all, :conditions => ["#{User.table_name}.id IN (SELECT DISTINCT user_id FROM members WHERE project_id=(?))", project.id]).sort
      return 'Can\'t find any users' if userlist.nil?

	  #Send this off to be rendered
      render :partial => 'wiki/members_gmap', :locals => {:users => userlist, :project => project, :roleorder => roleorder, :height => height}

	 end  
   end
end
