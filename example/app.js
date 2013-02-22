
var tools = require('bencoding.ios.tools');
Ti.API.info("module is => " + tools);

//Let's assume we are angry birds
var queryITunesID = '409807569';
Ti.API.info('We are querying for iTunes ID = ' + queryITunesID);

Ti.API.info("We will use our app version which is " + Ti.App.version);

var appStoreHelpers = tools.createAppStoreHelpers();
	
var win = Ti.UI.createWindow({
	backgroundColor:'white'
});

var launchButton = Ti.UI.createButton({
	title:'Launch App Store',
	top:40, height:45, right:10, left:10
});
win.add(launchButton);
launchButton.addEventListener('click',function(e){
	//Open app store for this ID
	appStoreHelpers.launch(queryITunesID);
});

var checkButton = Ti.UI.createButton({
	title:'Query version Info',
	top:120, height:45, right:10, left:10
});
win.add(checkButton);

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

checkButton.addEventListener('click',function(e){
	appStoreHelpers.versionCheck(queryITunesID,queryResults);
});

win.open();

