if not (IsAddOnLoaded("Tukui") or IsAddOnLoaded("AsphyxiaUI") or IsAddOnLoaded("DuffedUI")) then return end
local AS = unpack(select(2,...))

local name = "CritlineSkin"
function AS:SkinCritline()
	AS:SkinBackdropFrame(Critline.display, true)
	Critline.display.Backdrop:SetFrameStrata("BACKGROUND")
end

AS:RegisterSkin(name, AS.SkinCritline)