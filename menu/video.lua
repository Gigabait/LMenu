vid_width	= CreateConVar("vid_width", "640", {FCVAR_ARCHIVE})
vid_fps		= CreateConVar("vid_fps", "30", {FCVAR_ARCHIVE})

concommand.Add("gm_video", function()

	if ActiveVideo then
		ActiveVideo:Finish()
		ActiveVideo = nil
		return 
	end

	local dynamic_name = game.GetMap().." "..util.DateStamp()
	
	local width = vid_width:GetFloat()
	local fps = vid_fps:GetFloat()
	
	ActiveVideo, error = video.Record( 
	{
		name		= dynamic_name,
		container	= "webm",
		video		= "vp8",
		audio		= "vorbis",
		quality		= 0,
		bitrate		= 1024 * 64,
		width		= width,
		height		= ScrH() * (width / ScrW()),
		fps			= fps,
		lockfps		= true
		
	});
	
	if not ActiveVideo then
		MsgC(Color(0xFF, 0, 0), "[VideoRecord]") MsgC(Color(0xFF, 0xFF, 0xFF), "Couldn't record video: "..error)
		return
	end

end, nil, "", {FCVAR_DONTRECORD})


hook.Add("DrawOverlay", "CaptureFrames", function()
	if not ActiveVideo then return end
	ActiveVideo:AddFrame( FrameTime(), true )
end)
