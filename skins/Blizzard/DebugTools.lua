if not (IsAddOnLoaded("Tukui") or IsAddOnLoaded("AsphyxiaUI") or IsAddOnLoaded("DuffedUI")) then return end
local AS = unpack(select(2,...))

local name = "Blizzard_DebugToolsSkin"
function AS:SkinBlizzard_DebugTools(event, addon)
	if event == "PLAYER_ENTERING_WORLD" or addon ~= "Blizzard_DebugTools" then return end
	ScriptErrorsFrame:SetParent(UIParent)
	AS:SkinFrame(EventTraceFrame, "Default")
	AS:SkinFrame(ScriptErrorsFrame, "Default")
	for i = 1, ScriptErrorsFrame:GetNumChildren() do
		local child = select(i, ScriptErrorsFrame:GetChildren())
		if child:GetObjectType() == "Button" and not child:GetName() then
			AS:SkinButton(child)
		end
	end

	AS:SkinCloseButton(ScriptErrorsFrameClose)
	AS:SkinScrollBar(ScriptErrorsFrameScrollFrameScrollBar)
	EventTraceFrameScrollBG:SetTexture(nil)
	ScriptErrorsFrameScrollFrameScrollBar:ClearAllPoints()
	ScriptErrorsFrameScrollFrameScrollBar:SetPoint("TOPRIGHT", 50, 14)
	ScriptErrorsFrameScrollFrameScrollBar:SetPoint("BOTTOMRIGHT", 50, -20)
	AS:SkinCloseButton(EventTraceFrameCloseButton)
end

AS:RegisterSkin(name, AS.SkinBlizzard_DebugTools, "ADDON_LOADED")