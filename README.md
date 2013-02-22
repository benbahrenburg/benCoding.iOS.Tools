
BenCoding.iOSTools

This module contains a collection of tools designed to make working with Titanium on iOS even easier.

<h2>Before you start</h2>
* This is an iOS module designed to work with Titanium SDK 3.0.0.GA
* Before using this module you first need to install the package. If you need instructions on how to install a 3rd party module please read this installation guide.

<h2>Download the release</h2>

There is two ways you can download this module. The go to the [dist](https://github.com/benbahrenburg/Securely/tree/master/iOS/dist) folder. This will have a release compiled for anyone download it from github.


<h2>Building from source?</h2>

If you are building from source you will need to do the following:
* Modify the titanium.xcconfig file with the path to your Titanium installation

<h2>Setup</h2>

* Download the latest release from the releases folder ( or you can build it yourself )
* Install the bencoding.sms module. If you need help here is a "How To" [guide](https://wiki.appcelerator.org/display/guides/Configuring+Apps+to+Use+Modules). 
* You can now use the module via the commonJS require method, example shown below.

<pre><code>
var tools = require('bencoding.ios.tools');
Ti.API.info("module is => " + tools);
</code></pre>

<h2>Creating the Properties Object</h2>

Requiring the module into your project

<h2>AppStoreHelpers</h2>
The AppStoreHelpers object provides tools to help work with the Apple AppStore.

<h2>Methods</h2>

<b>versionCheck</b>( String iTunesID, Callback<Object> callback )
The versionCheck method provides the ability to query the AppStore and return the latest version information for a provide iTunes ID.

<b>Parameters</b>
iTunesID : String
The iTunes Id for the App.
callback : Callback<Object>
Callback function to invoke when completed

<b>Returns</b>
N/A

<b>Example</b>
<pre><code>
var tools = require('bencoding.ios.tools');
var appStoreHelpers = tools.createAppStoreHelpers();

function queryResults(e){
	
	Ti.API.info(JSON.stringify(e));
	
	Ti.API.info("success = " + e.success);
	Ti.API.info("appStoreVersion = " + e.appStoreVersion);
	Ti.API.info("appID = " + e.appID);
	Ti.API.info("code = " + e.code);
	Ti.API.info("installedVersion = " + e.installedVersion);
	
	if((parseFloat(e.installedVersion) < parseFloat(e.appStoreVersion))){
		var alert = Ti.UI.createAlertDialog({
			title:'Update now', 
			message:'There is a new version available. Do you want to download now?',
			buttonNames : ['OK','Cancel']
		});
		
		alert.addEventListener('click', function(y){
			if(y.index == 0){
				appStoreHelpers.launch(queryITunesID);
			}
		});
		alert.show();
	}
};

//Let's assume we are angry birds
var queryITunesID = '409807569';
//Call the check version method
appStoreHelpers.versionCheck(queryITunesID,queryResults);
</code></pre>

----

<b>launch</b>( String iTunesID)
Launches the AppStore for a provided iTunes Id

<b>Parameters</b>
iTunesID : String
The iTunes Id for the App.

<b>Returns</b>
N/A

<b>Example</b>
<pre><code>
var tools = require('bencoding.ios.tools');
var appStoreHelpers = tools.createAppStoreHelpers();

//Let's assume we are angry birds
var queryITunesID = '409807569';

//Open the App Store
appStoreHelpers.launch(queryITunesID);
</code></pre>

----

<h4>Finding your iTunes Id</h4>
To find your iTunes Id open iTunes and go to your app.  Right click on the App's iTunes coverart and select the Copy Link option. For example, if you do this on Angry Birds you will recieve the following url https://itunes.apple.com/us/app/angry-birds-free/id409807569?mt=8.

The section after the id and before the question mark is your iTunes Id.  Using our Angry Bird's example their iTunes Id would be 409807569.  This is the value you will want to use when launching or performing a version check.

<h2>Licensing & Support</h2>

This project is licensed under the OSI approved Apache Public License (version 2). For details please see the license associated with each project.

Developed by [Ben Bahrenburg](http://bahrenburgs.com) available on twitter [@benCoding](http://twitter.com/benCoding)

<h2>Learn More</h2>

<h3>Examples</h3>
Please check the module's example folder or [github repo](https://github.com/benbahrenburg/benCoding.iOS.Tools/tree/master/example) for samples on how to use this project.

<h3>Twitter</h3>

Please consider following the [@benCoding Twitter](http://www.twitter.com/benCoding) for updates 
and more about Titanium.

<h3>Blog</h3>

For module updates, Titanium tutorials and more please check out my blog at [benCoding.Com](http://benCoding.com).