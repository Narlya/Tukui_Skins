if not (IsAddOnLoaded("Tukui") or IsAddOnLoaded("AsphyxiaUI") or IsAddOnLoaded("DuffedUI")) then return end
local US = unpack(select(2,...))

local name = "DKDotsSkin"
function US:SkinDKDots()
	US:SkinBackdropFrame(DKDotsTarget)
end

US:RegisterSkin(name, US.SkinDKDots)