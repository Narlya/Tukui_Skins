if not (IsAddOnLoaded("ElvUI") or IsAddOnLoaded("Tukui")) then return end
local U = unpack(select(2,...))
local MiscFixes = CreateFrame("Frame")
	MiscFixes:RegisterEvent("PLAYER_ENTERING_WORLD")
	MiscFixes:RegisterEvent("PLAYER_REGEN_ENABLED")
	MiscFixes:RegisterEvent("PLAYER_REGEN_DISABLED")
	MiscFixes:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_REGEN_DISABLED" then
		if IsAddOnLoaded("tCombo") then
			if tComboPoints then tComboPoints:SetTemplate("Transparent") end
			if tComboEnergyBar then tComboEnergyBar:SetTemplate("Transparent") end
		end
	else

	if IsAddOnLoaded("TomTom") then if TomTomBlock then TomTomBlock:SetTemplate("Transparent") end end
	if IsAddOnLoaded("SymbiosisTip") then SymbiosisTip:HookScript("OnShow", function(self) self:SetTemplate("Transparent") end) end
	if IsAddOnLoaded("VengeanceStatus") then U.SkinStatusBar(VengeanceStatus_StatusBar) end
	
	LoadAddOn("acb_CastBar")
	if IsAddOnLoaded("acb_CastBar") then
		AzCastBarPluginPlayer:StripTextures() AzCastBarPluginPlayer:CreateBackdrop()
		AzCastBarPluginTarget:StripTextures() AzCastBarPluginTarget:CreateBackdrop()
		AzCastBarPluginFocus:StripTextures() AzCastBarPluginFocus:CreateBackdrop()
		AzCastBarPluginMirror:StripTextures() AzCastBarPluginMirror:CreateBackdrop()
		AzCastBarPluginPet:StripTextures() AzCastBarPluginPet:CreateBackdrop()
	end

	if (U.CheckOption("AzilSettings")) then
		TukuiPlayer_Experience:ClearAllPoints()
		TukuiPlayer_Experience:Point('BOTTOM', InvTukuiActionBarBackground, 'TOP', 0, 4)
		TukuiPlayer_Experience:Height(8)
		TukuiPlayer_Experience:SetFrameStrata("BACKGROUND")

		if (select(2, UnitClass("player")) == "ROGUE") then
			TukuiStance:SetParent(TukuiUIHider)
		end
	end
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	end
end)


-----------------------------------------
-- Loot auto confirm
-----------------------------------------

local LootConfirmer = CreateFrame("Frame")
LootConfirmer:RegisterEvent("PLAYER_ENTERING_WORLD");
LootConfirmer:RegisterEvent("CONFIRM_DISENCHANT_ROLL");
LootConfirmer:RegisterEvent("CONFIRM_LOOT_ROLL");
LootConfirmer:RegisterEvent("LOOT_OPENED");
LootConfirmer:SetScript("OnEvent",
	function(self, event, ...)
		if (U.CheckOption("LootConfirmer")) then
		if event == "PLAYER_ENTERING_WORLD" then
			StaticPopupDialogs["CONFIRM_LOOT_ROLL"] = nil
			--StaticPopupDialogs["LOOT_BIND"] = nil
		elseif event == "CONFIRM_LOOT_ROLL" or event == "CONFIRM_DISENCHANT_ROLL" then
			local arg1, arg2 = ...;
			ConfirmLootRoll(arg1, arg2);
		elseif event == "LOOT_OPENED" then
			cnt = GetNumLootItems()
			if cnt == 0 then
				CloseLoot()
			else
				for slot = 1, cnt do
					ConfirmLootSlot(slot)
				end
			end
		end
	end
end)
local ChatLootIcons = CreateFrame("Frame")
ChatLootIcons:RegisterEvent("PLAYER_ENTERING_WORLD");
ChatLootIcons:SetScript("OnEvent", function() 
	if (U.CheckOption("ChatLootIcons")) then
		EnableLootIcons()
	else
		DisableLootIcons()
	end
end)

local function AddLootIcons(self, event, message, ...)
	local _, fontSize = GetChatWindowInfo(self:GetID())
	local function IconForLink(link)
		local texture = GetItemIcon(link)
		return "\124T" .. texture .. ":" .. fontSize .. "\124t" .. link
	end
	message = message:gsub("(\124c%x+\124Hitem:.-\124h\124r)", IconForLink)
	return false, message, ...
end

function EnableLootIcons()
	ChatFrame_AddMessageEventFilter("CHAT_MSG_LOOT", AddLootIcons)
end

function DisableLootIcons()
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_LOOT", AddLootIcons)
end


--local T, C, L, G = unpack(Tukui)

local _

----------------------------------------
-- Credit to PetBattleQualityGlow addon
----------------------------------------

local function GetPetDumpList(targetID)
	local returned = nil

	for i=1,C_PetJournal.GetNumPets(false) do 
		id,speciesID,_,_,_,_,_,n,_,_,_,d=C_PetJournal.GetPetInfoByIndex(i)
		
		if speciesID == targetID then
			if returned == nil then
				returned = C_PetJournal.GetBattlePetLink(id)
			else
				returned = returned..", "..C_PetJournal.GetBattlePetLink(id)
			end
		end
	end
	
	return returned
end

local function GetZoneDumpList()
	local returned = nil
	local x={}
	
	for i=1,C_PetJournal.GetNumPets(false) do 
		id,speciesID,_,_,_,_,_,n,_,_,_,d=C_PetJournal.GetPetInfoByIndex(i)
		
		if string.find(d, GetZoneText()) and not x[n] then
			if id>0 then
				if returned == nil then returned = C_PetJournal.GetBattlePetLink(id) else returned = returned..", "..C_PetJournal.GetBattlePetLink(id) end
			else
				if returned == nil then returned = n else returned = returned..", "..n end
				x[n]=1
			end
		end
	end
	
	return returned
end

local function PetDump()
	local isWildPetBattle = (C_PetBattles.IsInBattle() and C_PetBattles.IsWildBattle())
	
	if (isWildPetBattle) then 
		local activePet = C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY)
		local targetID = C_PetBattles.GetPetSpeciesID(LE_BATTLE_PET_ENEMY, activePet)
		
		local ownedDump = GetPetDumpList(targetID)
--		if ownedDump == nil then print("You do not own this pet.") else print("Owned: "..ownedDump) end
		if ownedDump == nil then RaidNotice_AddMessage(RaidWarningFrame, "You do not own this pet.", ChatTypeInfo["RAID_WARNING"]) else RaidNotice_AddMessage(RaidWarningFrame, "Owned: "..ownedDump, ChatTypeInfo["RAID_WARNING"]) end
	else
		local zoneDump = GetZoneDumpList()
		if zoneDump ~= nil then print("Zone: "..GetZoneDumpList()) end
	end
end

function KyleuiPetBattleGlow_Update(self)
	-- There must be a petOwner and a petIndex
	if (not self.petOwner) or (not self.petIndex) then return end
	
	
	-- Check if this is the Tooltip
	local isTooltip = false
	if (self:GetName() == "PetBattlePrimaryUnitTooltip") then isTooltip = true end
	
	-- if not isTooltip then
		-- local species = C_PetBattles.GetPetSpeciesID(self.petOwner, self.petIndex)
		-- if not species then
			-- print("Fighting unknown species!")
		-- else
			-- print("Fighting species "..species)
		-- end
	-- end
	
	-- Set the color for the Glow
	local nQuality = C_PetBattles.GetBreedQuality(self.petOwner, self.petIndex) - 1
	local r, g, b, hex = GetItemQualityColor(nQuality)
	
	if self.petOwner == LE_BATTLE_PET_ENEMY then
		if self.IconBackdrop then
			self.IconBackdrop:SetBackdropBorderColor(r,g,b)
			self.IconBackdrop:SetFrameLevel(2)
		else
			self:SetBackdropBorderColor(r,g,b)
		end
	end
	
	-- Color the non-active Health Bars with the Quality color
	if (self.ActualHealthBar) and (not isTooltip) then
		if (self.petIndex ~= 1) then
			-- Fix by: Nullberri
			-- self.ActualHealthBar:SetVertexColor(r, g, b)
			if (self.petIndex ~= C_PetBattles.GetActivePet(self.petOwner)) then
				self.ActualHealthBar:SetVertexColor(r, g, b)
			else
				self.ActualHealthBar:SetVertexColor(0, 1, 0)
			end
		end
	end
end

SLASH_KYLEPETDUMP1 = "/bp"
SLASH_KYLEPETDUMP2 = "/battlepetdump"
SlashCmdList.KYLEPETDUMP = function()
	PetDump(nil)
end

hooksecurefunc("PetBattleFrame_Display", PetDump)
hooksecurefunc("PetBattleUnitFrame_UpdateDisplay", KyleuiPetBattleGlow_Update)


--Minimap Button Skinning thanks to Sinaris

if IsAddOnLoaded("AsphyxiaUI") or IsAddOnLoaded("SinarisUI") then return end

local buttons = {
	"QueueStatusMinimapButton",
	"MiniMapTrackingButton",
	"MiniMapMailFrame",
	"HelpOpenTicketButton",
	"ElvConfigToggle",
	"DBMMinimapButton",
	"ZygorGuidesViewerMapIcon",
}

local function SkinButton(frame)
	local s = U.s
	if(frame:GetObjectType() ~= "Button") then return end

	for i, buttons in pairs(buttons) do
		if(frame:GetName() ~= nil) then
			if(frame:GetName():match(buttons)) then return end
			for z = 1,999 do
				if _G["GatherMatePin"..z] then return end
			end
		end
	end

	frame:SetPushedTexture(nil)
	frame:SetHighlightTexture(nil)
	frame:SetDisabledTexture(nil)
	frame:Size(24)

	for i = 1, frame:GetNumRegions() do
		local region = select(i, frame:GetRegions())
		if(region:GetObjectType() == "Texture") then
			local tex = region:GetTexture()

			if(tex and (tex:find("Border") or tex:find("Background") or tex:find("AlphaMask"))) then
				region:SetTexture(nil)
			else
				region:ClearAllPoints()
				region:Point("TOPLEFT", frame, "TOPLEFT", 2, -2)
				region:Point("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2, 2)
				region:SetTexCoord( 0.1, 0.9, 0.1, 0.9 )
				region:SetDrawLayer( "ARTWORK" )
				if(frame:GetName() == "PS_MinimapButton") then
					region.SetPoint = s.dummy
				end
			end
		end
	end

	frame:SetTemplate("Default")
end

local UISkinMinimapButtons = CreateFrame("Frame")
UISkinMinimapButtons:RegisterEvent("PLAYER_ENTERING_WORLD")
UISkinMinimapButtons:SetScript("OnEvent", function(self, event)
	if (not U.CheckOption("UISkinMinimap")) then return end
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	for i = 1, Minimap:GetNumChildren() do
		SkinButton(select(i, Minimap:GetChildren()))
	end

	self = nil
end )