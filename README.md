Redmine Members Google Map plugin
=================================

This plugin for Redmine adds a wiki macro that will generate a Google Map showing member locations based on a custom user field

## Requirements

* Redmine version >= 2.x.x

## Installation

Check the requirements!

Download the sources and put them to your vendor/plugins folder.

    $ cd {REDMINE_ROOT}
    $ git clone https://github.com/TriggerAu/redmine_membersgmap.git plugins/redmine_membersgmap

Restart Redmine and have a fun!

## Usage

This macro can be used on wiki pages to insert a Google map that shows markers for project members.

It uses an opt-in model, so if a user does not fill in the custom field then they will not be "mapped"



		desc"Draw a Google Map that shows current Project Users - if they enroll - Wiki Only" + "\n\n" +
			"<pre>{{members_gmap(custom field name)}}\n" + 
			"  ...Basic map - provide the custom field that extends users\n       and contains map location</pre>" + "\n\n" +
			"<pre>{{members_gmap(custom field name, height=400, centerlong=30, showdaylight=true)}}\n" + 
			"  ...Options Example - The map will be 400pix high, centered on longitude 30 and show a daynight overlay</pre>" + "\n" +
			"Options List\n" +
			"<pre>" +
			"custom field name:   Text name of the custom field that holds location data\n                      eg. \"Sydney, Australia\" or \"Zimbabwe\"\n" + 
			"roleorder:           csv order to search roles - first found one selects role (default. roleorder=\"Developer,Manager,Reporter\")\n" + 
			"showdaylight:        boolean whether to add a daynight overlay (default. showdaylight=false)\n" + 
			"centerlat:           what latitude to center the map at (default. centerlat=10)\n" + 
			"centerlong:          what latitude to center the map at (default. centerlong=20)\n" + 
			"zoominitial:         starting zoom of the map (default. zoominitial=2)\n" + 
			"zoommin:             limit zoom out option (default. zoommin=2)\n" + 
			"</pre>"

## Changelog

### 0.1.0

- First public release
