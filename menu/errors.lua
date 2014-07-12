local Errors = {}

local matAlert = Material("icon16/error.png")

local surface_SetFont, surface_SetTextColor, surface_SetTextPos, surface_DrawText = surface.SetFont, surface.SetTextColor, surface.SetTextPos, surface.DrawText
local surface_SetDrawColor, surface_SetMaterial, surface_DrawTexturedRect, surface.GetTextSize = surface.SetDrawColor, surface.SetMaterial, surface.DrawTexturedRect, surface.GetTextSize

local Color, SysTime = Color, SysTime

local draw_RoundedBox, math_sin = draw.RoundedBox, math.sin

local color_gray, color_white = Color(40, 40, 40, 255), Color(240, 240, 240, 255)

hook.Add("OnLuaError", "MenuErrorHandler", function(str, realm, addontitle, addonid)

	local text = "Something is creating script errors"
	
	local ST = SysTime()
	
	if isstring(addonid) then

		text = "The addon \""..addontitle.."\" is creating errors, check the console for details"

	end

	if  addonid == nil then addonid = 0 end

	if Errors[addonid] then

		Errors[addonid].times	= Errors[addonid].times + 1
		Errors[addonid].last	= ST

		return
	end

	local error =
	{
		first	= ST,
		last	= ST,
		times	= 1,
		title	= addontitle,
		x		= 32,
		text	= text
	}

	Errors[addonid] = error

end)

hook.Add( "DrawOverlay", "MenuDrawLuaErrors", function()
	
	if #Errors == 0 then return end

	local ST = SysTime()
	
	local idealy = 32
	local height = 30
	local EndTime = ST - 10
	local Recent = ST - 0.5

	for k, v in SortedPairsByMemberValue(Errors, "last") do

		surface_SetFont("DermaDefaultBold")
		if v.y == nil then v.y = idealy end
		if v.w == nil then v.w = surface_GetTextSize( v.text ) + 48 end

		
		draw_RoundedBox(2, v.x + 2, v.y + 2, v.w, height, color_gray)
		draw_RoundedBox(2, v.x, v.y, v.w, height, color_white)

		if v.last > Recent then

			draw_RoundedBox(2, v.x, v.y, v.w, height, Color(255, 200, 0, (v.last - Recent) * 510))

		end

		surface_SetTextColor(90, 90, 90, 255)
		surface_SetTextPos(v.x + 34, v.y + 8)
		surface_DrawText(v.text)

		surface_SetDrawColor(255, 255, 255, 150 + math_sin(v.y + ST * 30) * 100)
		surface_SetMaterial(matAlert)
		surface_DrawTexturedRect(v.x + 6, v.y + 6, 16, 16)

		v.y = idealy

		idealy = idealy + 40

		if v.last < EndTime then
			Errors[k] = nil
		end

	end

end)
