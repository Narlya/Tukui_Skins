if not (IsAddOnLoaded("Tukui") or IsAddOnLoaded("AsphyxiaUI") or IsAddOnLoaded("DuffedUI")) then return end
local AS = unpack(select(2,...))

local name = "Blizzard_BlackMarketUISkin"
function AS:SkinBlizzard_BlackMarketUI(event, addon)
	BlackMarketFrame:StripTextures()
	BlackMarketFrame.Inset:StripTextures()
	BlackMarketFrame:SetTemplate()
	BlackMarketScrollFrameScrollBar:SkinScrollBar()
	BlackMarketFrame.MoneyFrameBorder:StripTextures()
	BlackMarketBidPriceGold:SkinEditBox()
	BlackMarketBidPriceGold:Height(16)
	BlackMarketFrame.HotDeal.Item.IconTexture:SetTexCoord(.08, .92, .08, .92)
	BlackMarketFrame.BidButton:SkinButton()
	BlackMarketFrame.BidButton:Height(20)
	BlackMarketFrame.HotDeal.BidButton:SkinButton()
	BlackMarketFrame.CloseButton:SkinCloseButton()

	local tabs = {"ColumnName", "ColumnLevel", "ColumnType", "ColumnDuration", "ColumnHighBidder", "ColumnCurrentBid"}
	for _, tab in pairs(tabs) do
		local tab = BlackMarketFrame[tab]
		tab.Left:Hide()
		tab.Middle:Hide()
		tab.Right:Hide()
		tab:CreateBackdrop()
		tab.Backdrop:Point("TOPLEFT", tab, 3, 0)
		tab.Backdrop:Point("BOTTOMRIGHT", tab, -3, 0)	
	end

	hooksecurefunc("BlackMarketScrollFrame_Update", function()
		local buttons = BlackMarketScrollFrame.buttons
		local numButtons = #buttons
		local offset = HybridScrollFrame_GetOffset(BlackMarketScrollFrame)
		local numItems = C_BlackMarket.GetNumItems()

		for i = 1, numButtons do
			local button = buttons[i]
			local index = offset + i

			if not button.skinned then
				button.Item:StripTextures()
				button.Item:SetTemplate()
				button.Item.IconTexture:SetInside()
				button.Item.IconTexture:SetTexCoord(.1,.9,.1,.9)
				button.Item:StyleButton()
				button:StripTextures()
				button.skinned = true
			end

			if ( index <= numItems ) then
				local name, texture = C_BlackMarket.GetItemInfoByIndex(index)
				if name then
					button.Item.IconTexture:SetTexture(texture)
				end
			end
		end
	end)

	BlackMarketFrame.HotDeal:StripTextures()
	BlackMarketFrame.HotDeal.Item:CreateBackdrop()
	BlackMarketFrame.HotDeal.Item:StyleButton()
	BlackMarketFrame.HotDeal.Item.hover:SetAllPoints()
	BlackMarketFrame.HotDeal.Item.pushed:SetAllPoints()
	BlackMarketFrame.HotDeal.BidButton:SkinButton()
	BlackMarketHotItemBidPriceGold:SkinEditBox()

	for i = 1, BlackMarketFrame:GetNumRegions() do
		local region = select(i, BlackMarketFrame:GetRegions())
		if region and region:GetObjectType() == "FontString" and region:GetText() == BLACK_MARKET_TITLE then
			region:ClearAllPoints()
			region:SetPoint("TOP", BlackMarketFrame, "TOP", 0, -4)
		end
	end
end

AS:RegisterSkin(name, AS.SkinBlizzard_BlackMarketUI, "ADDON_LOADED")