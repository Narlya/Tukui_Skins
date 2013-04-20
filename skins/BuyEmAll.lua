if not (IsAddOnLoaded("Tukui") or IsAddOnLoaded("AsphyxiaUI") or IsAddOnLoaded("DuffedUI")) then return end
local U = unpack(select(2,...))

local name = "BuyEmAllSkin"
local function SkinBuyEmAll(self)
	U.SkinFrame(BuyEmAllFrame)
	U.SkinButton(BuyEmAllStackButton)
	U.SkinButton(BuyEmAllMaxButton)
	U.SkinButton(BuyEmAllCancelButton)
	U.SkinButton(BuyEmAllOkayButton)
end

U.RegisterSkin(name, SkinBuyEmAll)