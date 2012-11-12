-- Camealion's Functions File
-- Added ccolor for class coloring. - Azilroka
-- Restructured Functions file. - Azilroka
-- Added Skinning features for ease of skinning and smaller size skins. - Azilroka

local U = unpack(select(2,...))
local s = U.s

local function cSkinButton(self,strip)
	self:SkinButton(strip)
end

U.SkinButton = cSkinButton

local function cSkinScrollBar(self)
	self:SkinScrollBar()
end

U.SkinScrollBar = cSkinScrollBar

local function cSkinTab(self)
	self:SkinTab()
end

U.SkinTab = cSkinTab

local function cSkinNextPrevButton(self, horizonal)
	self:SkinNextPrevButton(horizonal)
end

U.SkinNextPrevButton = cSkinNextPrevButton

local function cSkinRotateButton(self)
	self:SkinRotateButton()
end

U.SkinRotateButton = cSkinRotateButton

local function cSkinEditBox(self)
	self:SkinEditBox()
end

U.SkinEditBox = cSkinEditBox

local function cSkinDropDownBox(self, width)
	self:SkinDropDownBox(width)
end

U.SkinDropDownBox = cSkinDropDownBox

local function cSkinCheckBox(self)
	self:SkinCheckBox()
end

U.SkinCheckBox = cSkinCheckBox

local function cSkinCloseButton(self)
	s.SkinCloseButton(self)
end

U.SkinCloseButton = cSkinCloseButton

local function cSkinSliderFrame(self, height)
	SkinSlideBar(self, height, movetext)
end

U.SkinSliderFrame = cSkinSliderFrame

function cRegisterForPetBattleHide(frame)
	if frame.IsVisible and frame:GetName() then
		U.FrameLocks[frame:GetName()] = { shown = false }
	end
end

local function cSkinFrame(self)
	self:StripTextures(True)
	self:SetTemplate("Transparent")
	cRegisterForPetBattleHide(self)
end

U.SkinFrame = cSkinFrame

local function cSkinBackdropFrame(self)
	self:StripTextures(True)
	self:CreateBackdrop("Transparent")
	cRegisterForPetBattleHide(self)
end

U.SkinBackdropFrame = cSkinBackdropFrame

local function cSkinFrameD(self)
	self:StripTextures(True)
	self:SetTemplate("Default")
	cRegisterForPetBattleHide(self)
end

U.SkinFrameD = cSkinFrameD

local function cSkinStatusBar(self)
	local s = U.s
	local c = U.c
	self:StripTextures(True)
	self:CreateBackdrop()
	self:SetStatusBarTexture(c["media"].normTex)
end

U.SkinStatusBar = cSkinStatusBar

local function cSkinCCStatusBar(self)
	local s = U.s
	local c = U.c
	self:StripTextures(True)
	self:CreateBackdrop("ClassColor")
	self:SetStatusBarTexture(c["media"].normTex)
	local color = RAID_CLASS_COLORS[U.ccolor]
	self:SetStatusBarColor(color.r, color.g, color.b)
end

U.SkinCCStatusBar = cSkinCCStatusBar

local function cDesaturate(f, point)
	for i=1, f:GetNumRegions() do
		local region = select(i, f:GetRegions())
		if region:GetObjectType() == "Texture" then
			region:SetDesaturated(1)

			if region:GetTexture() == "Interface\\DialogFrame\\UI-DialogBox-Corner" then
				region:Kill()
			end
		end
	end	

	if point then
		f:Point("TOPRIGHT", point, "TOPRIGHT", 2, 2)
	end
end

U.Desaturate = cDesaturate

local function cCheckOption(optionName,...)
	for i = 1,select('#',...) do
		local addon = select(i,...)
		if not addon then break end
		if not IsAddOnLoaded(addon) then return false end
	end
	return UISkinOptions[optionName] == "Enabled"
end

U.CheckOption = cCheckOption

local function cDisableOption(optionName)
	UISkinOptions[optionName] = "Disabled"
end

U.DisableOption = cDisableOption

local function cEnableOption(optionName)
	UISkinOptions[optionName] = "Enabled"
end

U.EnableOption = cEnableOption

local function cToggleOption(optionName)
	if cCheckOption(optionName) then
		cDisableOption(optionName)
	else
		cEnableOption(optionName)
	end
end

U.ToggleOption = cToggleOption

local function cRegisterSkin(skinName,skinFunc,...)
	local XS = U.x
	local events = {}
	for i = 1,select('#',...) do
		local event = select(i,...)
		if not event then break end
		events[event] = true
	end
	local registerMe = { func = skinFunc, events = events }
	if not XS.register[skinName] then XS.register[skinName] = {} end
	XS.register[skinName][skinFunc] = registerMe
end

U.RegisterSkin = cRegisterSkin

local function cUnregisterEvent(skinName,frame,event)
	local XS = U.x
	XS:UnregisterEvent(skinName,event)
end

U.UnregisterEvent = cUnregisterEvent

function cAddNonPetBattleFrames()
	for frame,data in pairs(U.FrameLocks) do
		if data.shown then
			_G[frame]:Show()
		end
	end
end

U.AddNonPetBattleFrames = cAddNonPetBattleFrames

function cRemoveNonPetBattleFrames()
	for frame,data in pairs(U.FrameLocks) do
		if(_G[frame]:IsVisible()) then
			data.shown = true
			_G[frame]:Hide()
		else
			data.shown = false
		end
	end
end

U.RemoveNonPetBattleFrames = cRemoveNonPetBattleFrames

function AzilCompatMode()
	_G["cSkinButton"] = cSkinButton
	_G["cSkinScrollBar"] = cSkinScrollBar
	_G["cSkinTab"] = cSkinTab
	_G["cSkinNextPrevButton"] = cSkinNextPrevButton
	_G["cSkinRotateButton"] = cSkinRotateButton
	_G["cSkinEditBox"] = cSkinEditBox
	_G["cSkinDropDownBox"] = cSkinDropDownBox
	_G["cSkinCheckBox"] = cSkinCheckBox
	_G["cSkinCloseButton"] = cSkinCloseButton
	_G["cSkinSliderFrame"] = cSkinSliderFrame
	_G["cSkinFrame"] = cSkinFrame
	_G["cSkinBackdropFrame"] = cSkinBackdropFrame
	_G["cSkinFrameD"] = cSkinFrameD
	_G["cSkinStatusBar"] = cSkinStatusBar
	_G["cSkinCCStatusBar"] = cSkinCCStatusBar
	_G["cDesaturate"] = cDesaturate
	_G["cCheckOption"] = cCheckOption
	_G["cDisableOption"] = cDisableOption
	_G["cEnableOption"] = cEnableOption
	_G["cToggleOption"] = cToggleOption
	_G["cRegisterSkin"] = cRegisterSkin
	_G["cUnregisterEvent"] = cUnregisterEvent
end

SLASH_FRAME1 = "/frame"
SlashCmdList["FRAME"] = function(arg)
	if arg ~= "" then
		arg = _G[arg]
	else
		arg = GetMouseFocus()
	end

	if arg ~= nil and arg:GetName() ~= nil then
		local point, relativeTo, relativePoint, xOfs, yOfs = arg:GetPoint()
		ChatFrame1:AddMessage("|cffCC0000~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
		ChatFrame1:AddMessage("Name: |cffFFD100"..arg:GetName())
		if arg:GetParent() then
			ChatFrame1:AddMessage("Parent: |cffFFD100"..arg:GetParent():GetName())
		end

		ChatFrame1:AddMessage("Width: |cffFFD100"..format("%.2f",arg:GetWidth()))
		ChatFrame1:AddMessage("Height: |cffFFD100"..format("%.2f",arg:GetHeight()))
		ChatFrame1:AddMessage("Strata: |cffFFD100"..arg:GetFrameStrata())
		ChatFrame1:AddMessage("Level: |cffFFD100"..arg:GetFrameLevel())

		if xOfs then
			ChatFrame1:AddMessage("X: |cffFFD100"..format("%.2f",xOfs))
		end
		if yOfs then
			ChatFrame1:AddMessage("Y: |cffFFD100"..format("%.2f",yOfs))
		end
		if relativeTo then
			ChatFrame1:AddMessage("Point: |cffFFD100"..point.."|r anchored to "..relativeTo:GetName().."'s |cffFFD100"..relativePoint)
		end
		ChatFrame1:AddMessage("|cffCC0000~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
	elseif arg == nil then
		ChatFrame1:AddMessage("Invalid frame name")
	else
		ChatFrame1:AddMessage("Could not find frame info")
	end
end