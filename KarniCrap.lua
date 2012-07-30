if not (IsAddOnLoaded( "ElvUI" ) or IsAddOnLoaded("Tukui")) then return end
if not IsAddOnLoaded("KarniCrap") then return end
local SkinKarniCrap = CreateFrame("Frame")
	SkinKarniCrap:RegisterEvent( "PLAYER_ENTERING_WORLD" )
	SkinKarniCrap:SetScript( "OnEvent", function(self)
	if (UISkinOptions.KarniCrapSkin == "Disabled") then return end
local s = UIPackageSkinFuncs.s
local c = UIPackageSkinFuncs.c

	KarniCrap:StripTextures()
	KarniCrap:SetTemplate("Transparent")
	KarniCrap_CategoryFrame:StripTextures()
	KarniCrap_CategoryFrame:SetTemplate("Transparent")
	KarniCrap_OptionsFrame:StripTextures()
	KarniCrap_OptionsFrame:SetTemplate("Transparent")
	KarniCrap_Blacklist:StripTextures()
	KarniCrap_Blacklist:SetTemplate("Transparent")
	KarniCrap_Whitelist:StripTextures()
	KarniCrap_Whitelist:SetTemplate("Transparent")
	KarniCrap_Inventory:StripTextures()
	KarniCrap_Inventory:SetTemplate("Transparent")
	KarniCrap_Inventory_ScrollBar:StripTextures()
	KarniCrapTab1:Point("BOTTOMLEFT", KarniCrap, "BOTTOMLEFT",0,-30)
	cSkinScrollBar(KarniCrap_Inventory_ScrollBarScrollBar)
	cSkinButton(KarniCrap_BtnBlacklistRemove)
	cSkinButton(KarniCrap_BtnWhitelistRemove)
	cSkinCloseButton(KarniCrapCloseButton)
	cSkinTab(KarniCrapTab1)
	cSkinTab(KarniCrapTab2)
	cSkinTab(KarniCrapTab3)
	cSkinButton(KarniCrap_InvHeader1)
	cSkinButton(KarniCrap_InvHeader2)
	cSkinButton(KarniCrap_ValueHeader)
	cSkinButton(KarniCrap_InvHeader4)
	cSkinButton(KarniCrap_BtnDestroyItem)
	cSkinButton(KarniCrap_BtnDestroyAllCrap)
	KarniCrapPortrait:Kill()

	--Checkboxes
	cSkinCheckBox(KarniCrap_CBEnabled)
	cSkinCheckBox(KarniCrap_CBPoor)
	cSkinCheckBox(KarniCrap_Tab1_CBCommon)
	cSkinCheckBox(KarniCrap_Tab1_CBUseStackValue)
	cSkinCheckBox(KarniCrap_Tab1_CBEcho)
	cSkinCheckBox(KarniCrap_CBDestroy)
	cSkinCheckBox(KarniCrap_CBDestroySlots)
	cSkinCheckBox(KarniCrap_CBNoDestroyTradeskill)
	cSkinCheckBox(KarniCrap_CBDestroyGroup)
	cSkinCheckBox(KarniCrap_CBDestroyRaid)
	cSkinCheckBox(KarniCrap_Cloth_CBLinen)
	cSkinCheckBox(KarniCrap_Cloth_CBLinen_Never)
	cSkinCheckBox(KarniCrap_Cloth_CBWool)
	cSkinCheckBox(KarniCrap_Cloth_CBWool_Never)
	cSkinCheckBox(KarniCrap_Cloth_CBSilk)
	cSkinCheckBox(KarniCrap_Cloth_CBSilk_Never)
	cSkinCheckBox(KarniCrap_Cloth_CBMageweave)
	cSkinCheckBox(KarniCrap_Cloth_CBMageweave_Never)
	cSkinCheckBox(KarniCrap_Cloth_CBRunecloth)
	cSkinCheckBox(KarniCrap_Cloth_CBRunecloth_Never)
	cSkinCheckBox(KarniCrap_Cloth_CBNetherweave)
	cSkinCheckBox(KarniCrap_Cloth_CBNetherweave_Never)
	cSkinCheckBox(KarniCrap_Cloth_CBFrostweave)
	cSkinCheckBox(KarniCrap_Cloth_CBFrostweave_Never)
	cSkinCheckBox(KarniCrap_Cloth_CBEmbersilk)
	cSkinCheckBox(KarniCrap_Cloth_CBEmbersilk_Never)
	cSkinCheckBox(KarniCrap_Corpses_CBSkinnable)
	cSkinCheckBox(KarniCrap_Corpses_CBGatherable)
	cSkinCheckBox(KarniCrap_Corpses_CBMinable)
	cSkinCheckBox(KarniCrap_Corpses_CBEngineerable)
	cSkinCheckBox(KarniCrap_Corpses_CBSkilledEnough)
	cSkinCheckBox(KarniCrap_Consumables_RBFood1)
	cSkinCheckBox(KarniCrap_Consumables_RBFood2)
	cSkinCheckBox(KarniCrap_Consumables_CBFoodMax)
	cSkinCheckBox(KarniCrap_Consumables_RBWater1)
	cSkinCheckBox(KarniCrap_Consumables_RBWater2)
	cSkinCheckBox(KarniCrap_Consumables_CBWaterMax)
	cSkinCheckBox(KarniCrap_Potions_RBHealth1)
	cSkinCheckBox(KarniCrap_Potions_RBHealth2)
	cSkinCheckBox(KarniCrap_Potions_CBHealthMax)
	cSkinCheckBox(KarniCrap_Potions_RBMana1)
	cSkinCheckBox(KarniCrap_Potions_RBMana2)
	cSkinCheckBox(KarniCrap_Potions_CBManaMax)
	cSkinCheckBox(KarniCrap_Quality_CBQualityPoor)
	cSkinCheckBox(KarniCrap_Quality_CBQualityCommon)
	cSkinCheckBox(KarniCrap_Quality_CBQualityUncommon)
	cSkinCheckBox(KarniCrap_Quality_CBQualityRare)
	cSkinCheckBox(KarniCrap_Quality_CBQualityEpic)
	cSkinCheckBox(KarniCrap_Quality_CBQualityGrouped)
	cSkinCheckBox(KarniCrap_Scrolls_CBMaxScrolls)
	cSkinCheckBox(KarniCrap_Scrolls_CBScrollAgility)
	cSkinCheckBox(KarniCrap_Scrolls_CBScrollIntellect)
	cSkinCheckBox(KarniCrap_Scrolls_CBScrollProtection)
	cSkinCheckBox(KarniCrap_Scrolls_CBScrollSpirit)
	cSkinCheckBox(KarniCrap_Scrolls_CBScrollStamina)
	cSkinCheckBox(KarniCrap_Scrolls_CBScrollStrength)
	cSkinCheckBox(KarniCrap_Tradeskills_CBCooking)
	cSkinCheckBox(KarniCrap_Tradeskills_CBFishing)
	cSkinCheckBox(KarniCrap_Tradeskills_CBPickpocketing)
	cSkinCheckBox(KarniCrap_Tradeskills_CBEnchanting)
	cSkinCheckBox(KarniCrap_Tradeskills_CBGathering)
	cSkinCheckBox(KarniCrap_Tradeskills_CBMilling)
	cSkinCheckBox(KarniCrap_Tradeskills_CBMining)
	cSkinCheckBox(KarniCrap_Tradeskills_CBProspecting)
	cSkinCheckBox(KarniCrap_Tradeskills_CBSkinning)
	cSkinCheckBox(KarniCrap_Inventory_CBHideQuestItems)
	cSkinCheckBox(KarniCrap_CBOpenAtMerchant)

for i = 1, 15 do
	cSkinCloseButton(_G["KarniInvEntry"..i.."_BtnCrap"])
end

end)