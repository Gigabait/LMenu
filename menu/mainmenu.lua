concommand.Add("serverbrowser", function()
	RunGameUICommand("OpenServerBrowser")
end)

concommand.Add("settings", function()
	RunGameUICommand("OpenOptionsDialog")
end)

concommand.Add("workshop", function()
	--steamworks.OpenWorkshop()
	gui.OpenURL("http://steamcommunity.com/workshop/browse/?appid=4000&browsesort=mysubscriptions&browsefilter=mysubscriptions&p=1")
end)

hook.Add("WorkshopDownloadFile", "WorkshopDownloadFile", function(numID, numImageID, strTitle, numSize)
	MsgC(Color(120, 150, 255), "[Workshop] ") 
	MsgC(Color(255, 255, 255), "Downloading wokshop file: "..strTitle.." ( "..numID.." ) Size: "..string.NiceSize(numSize).." \n")
end)	

hook.Add("WorkshopDownloadedFile", "WorkshopDownloadedFile", function(numID, strTitle)
	MsgC(Color(120, 150, 255), "[Workshop] ") 
	MsgC(Color(255, 255, 255), "Downloaded wokshop file: "..strTitle.." ( "..numID.." ) \n")
end)