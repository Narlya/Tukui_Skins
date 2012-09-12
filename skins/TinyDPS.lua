if not (IsAddOnLoaded("Tukui") or IsAddOnLoaded("ElvUI")) or not IsAddOnLoaded("TinyDPS") then return end
local name = "TinyDPSSkin"
local function SkinTinyDps(self)
	local s = UIPackageSkinFuncs.s
	local c = UIPackageSkinFuncs.c
	local frame = tdpsFrame
	local anchor = tdpsAnchor
	local status = tdpsStatusBar
	local tdps = tdps
	local font = tdpsFont
	local position = tdpsPosition
	local template
	if cCheckOption("EmbedTDPS") then template = "Default" else template = "Transparent" end
	frame:SetTemplate(template, true)
	frame:CreateShadow("Default")
if IsAddOnLoaded("ElvUI") then
	if(tdps) then
		tdps.width = Minimap:GetWidth()
		tdps.spacing = 1
		tdps.barHeight = 14
		font.name = [[Interface\AddOns\ElvUI\media\fonts\Homespun.ttf]]
		font.size = 12
		font.outline = "THIN"
	end
end
	if(status) then
		tdpsStatusBar:SetBackdrop( {
			bgFile = c["media"].normTex,
			edgeFile = c["media"].blank,
			tile = false,
			tileSize = 0,
			edgeSize = 1,
			insets = {
				left = 0,
				right = 0,
				top = 0,
				bottom = 0
			}
		})
		tdpsStatusBar:SetStatusBarTexture(c["media"].normTex)
	end
if IsAddOnLoaded("Tukui") then
	if(tdps) then
		tdps.width = TukuiMinimap:GetWidth()
		tdps.spacing = 1
		tdps.barHeight = 14
		font.name = c["media"].pixelfont
		font.size = 12
		font.outline = "MONOCHROMEOUTLINE"
	end
	--anchor:Point("BOTTOMLEFT", TukuiMinimap, "BOTTOMLEFT", 0, -26)
	--frame:SetWidth(TukuiMinimap:GetWidth())
	--position = { x = 0, y = -6 }

	--local button = TukuiRaidUtilityShowButton
	--if(button) then
	--	button:HookScript("OnShow", function(self) 
	--		anchor:ClearAllPoints()
	--		anchor:Point("BOTTOMLEFT", TukuiMinimap, "BOTTOMLEFT", 0, -49)
	--	end)
	--	button:HookScript("OnHide", function(self) 
	--		anchor:ClearAllPoints()
	--		anchor:Point("BOTTOMLEFT", TukuiMinimap, "BOTTOMLEFT", 0, -26)
	--	end)
	--end
end
	if cCheckOption('EmbedTDPS') then EmbedTDPS() end
end

function EmbedTDPS()
	if not IsAddOnLoaded("TinyDPS") then cDisableOption("EmbedTDPS") return end
	if (cCheckOption("EmbedOoC")) then
		if (cCheckOption("EmbedTDPS")) then
			tdpsFrame:Hide()
		end
	end
	if IsAddOnLoaded("Tukui") or (IsAddOnLoaded("ElvUI") and not IsAddOnLoaded("ElvUI_SLE")) then
		tdps.spacing = 1
		tdps.barHeight = 16
		tdpsVisibleBars = 8
		tdpsFrame:SetWidth(EmbeddingWindow:GetWidth())
		tdpsAnchor:Point("TOPLEFT", EmbeddingWindow, "TOPLEFT", 0, 0)
		tdpsRefresh()
	end
	if IsAddOnLoaded("ElvUI_SLE") then
		tdps.spacing = 1
		tdps.barHeight = 16
		tdpsVisibleBars = 9
		tdpsFrame:SetWidth(EmbeddingWindow:GetWidth())
		tdpsAnchor:Point("TOPLEFT", EmbeddingWindow, "TOPLEFT", 0, 0)
		tdpsRefresh()
	end
end

cRegisterSkin(name,SkinTinyDps)