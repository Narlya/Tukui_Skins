if not (IsAddOnLoaded("Tukui") or IsAddOnLoaded("AsphyxiaUI") or IsAddOnLoaded("DuffedUI")) then return end
local AS = unpack(select(2,...))

local name = "SkadaSkin"
function AS:SkinSkada()
	local barSpacing = 1
	local borderWidth = 1
	
	local function StripOptions(options)
		options.baroptions.args.barspacing = nil
		options.titleoptions.args.texture = nil
		options.titleoptions.args.bordertexture = nil
		options.titleoptions.args.thickness = nil
		options.titleoptions.args.margin = nil
		options.titleoptions.args.color = nil
		options.windowoptions = nil
	end
	
	local ResetFrame = CreateFrame("Frame", nil, UIParent)
	ResetFrame:SetTemplate("Transparent")
	ResetFrame:SetSize(250, 70)
	ResetFrame:SetPoint("CENTER", UIParent, "CENTER")
	ResetFrame:SetFrameStrata("DIALOG")
	ResetFrame:Hide()
	ResetFrame:FontString("text", AS.PixelFont, 14, "MONOCHROMEOUTLINE")
	ResetFrame.text:SetPoint("TOP", ResetFrame, "TOP", 0, -10)
	ResetFrame.text:SetText("Do you want to reset Skada?")

	local ResetAccept = CreateFrame("Button", nil, ResetFrame)
	AS:SkinButton(ResetAccept)
	ResetAccept:SetSize(70, 25)
	ResetAccept:SetPoint("RIGHT", ResetFrame, "BOTTOM", -1, 20)
	ResetAccept:SetScript("OnClick", function(self) Skada:Reset() self:GetParent():Hide() end)
	ResetAccept:FontString("text", AS.PixelFont, 14, "MONOCHROMEOUTLINE")
	ResetAccept.text:SetPoint("CENTER")
	ResetAccept.text:SetText("Yes")

	local ResetClose = CreateFrame("Button", nil, ResetFrame)
	AS:SkinButton(ResetClose)
	ResetClose:SetSize(70, 25)
	ResetClose:SetPoint("LEFT", ResetFrame, "BOTTOM", 1, 20)
	ResetClose:SetScript("OnClick", function(self) self:GetParent():Hide() end)
	ResetClose:FontString("text", AS.PixelFont, 14, "MONOCHROMEOUTLINE")
	ResetClose.text:SetPoint("CENTER")
	ResetClose.text:SetText("Yes")
	
	function Skada:ShowPopup()
		ResetFrame:Show()
	end
	
	local barmod = Skada.displays["bar"]
	barmod.AddDisplayOptions_ = barmod.AddDisplayOptions
	barmod.AddDisplayOptions = function(self, win, options)
		self:AddDisplayOptions_(win, options)
		StripOptions(options)
	end

	for k, options in pairs(Skada.options.args.windows.args) do
		if(options.type == "group") then
			StripOptions(options.args)
		end
	end

	local titleBG = {
		bgFile = AS.NormTex,
		tile = false,
		tileSize = 0
	}

	barmod.ApplySettings_ = barmod.ApplySettings
	barmod.ApplySettings = function(self, win)
		barmod.ApplySettings_(self, win)
		local skada = win.bargroup
		if(win.db.enabletitle) then
			skada.button:SetBackdrop(titleBG)
		end
		skada:SetTexture(AS.NormTex)
		skada:SetSpacing(barSpacing)
		skada:SetFrameLevel(5)
		if not skada.TitleBackGround then
			skada.TitleBackGround = CreateFrame("Frame", nil, skada.button)
			skada.TitleBackGround:SetPoint("TOP")
			skada.TitleBackGround:SetPoint("LEFT")
			skada.TitleBackGround:SetPoint("RIGHT")
			skada.TitleBackGround:SetPoint("BOTTOM", 0, 1)
			AS:SkinFrame(skada.TitleBackGround,"Default")
			skada.TitleBackGround:SetFrameLevel(skada.button:GetFrameLevel() -1)
		end

		local titlefont = CreateFont("TitleFont" .. win.db.name)
		skada.button:SetNormalFontObject(titlefont)

		local color = win.db.title.color
		skada.button:SetBackdropColor(0, 0, 0, 0)
		skada:SetBackdrop(nil)
		AS:SkinBackdropFrame(skada)
		skada.Backdrop:ClearAllPoints()
		if win.db.enabletitle then
			skada.Backdrop:Point("TOPLEFT", skada.button, "TOPLEFT", -2, 2)
		else
			skada.Backdrop:Point("TOPLEFT", skada, "TOPLEFT", -2, 2)
		end
		skada.Backdrop:Point("BOTTOMRIGHT", skada, "BOTTOMRIGHT", 2, -2)
		if not AS:CheckOption("SkadaBackdrop") then skada.Backdrop:Hide() end
	end
end

AS:RegisterSkin(name, AS.SkinSkada)