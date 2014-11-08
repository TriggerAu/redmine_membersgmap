Redmine Members Google Map plugin
================================= 

This plugin for Redmine adds a wiki macro that will generate a Google Map showing member locations based on a custom user field

Author: TriggerAu

## Requirements

* Redmine version >= 2.x.x

## Installation

### 1. Install the plugin

Download the sources and put them to your vendor/plugins folder.

    $ cd {REDMINE_ROOT}
    $ git clone https://github.com/TriggerAu/redmine_membersgmap.git plugins/redmine_membersgmap

Restart Redmine

### 2. Create the custom field

1. under Admin in redmine click on Custom Fields
2. Click "New Custom Field"
3. Choose Users and click "Next >>"
4. Add a Text field and give it a name you will remember eg. "Google Maps Location"
5. I suggest adding a description that tells people what the field is used for and that if its empty they wont be mapped

## Usage

This macro can be used on wiki pages to insert a Google map that shows markers for project members.

It uses an opt-in model, so if a user does not fill in the custom field then they will not be "mapped"

Basic map - Draw a map using the custom field and default settings 
```
{{members_gmap(Google Maps Location)}}
```

Options Example - This map will be 400pix high, centered on longitude 30 and show a daynight overlay
```
{{members_gmap(Google Maps Location, height=400, centerlong=30, showdaylight=true)}}
```

#### Options

|Option|Description|Default|
|--- | --- | ---|
|roleorder|csv order to search roles - first found one selects role|roleorder="Developer,Manager,Reporter"|
|showdaylight|boolean whether to add a daynight overlay|showdaylight=false| 
|centerlat|what latitude to center the map at|centerlat=10|
|centerlong|what latitude to center the map at|centerlong=20|
|zoominitial|starting zoom of the map|zoominitial=2|
|zoommin|limit zoom out option|zoommin=2|

## Changelog

### 0.1.0

- First public release
