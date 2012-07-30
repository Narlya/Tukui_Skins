local frame = CreateFrame( "Frame" )
frame:RegisterEvent( "PLAYER_ENTERING_WORLD" )
frame:SetScript( "OnEvent", function( self, event )	
	if (UISkinOptions.TinyDPSSkin == "Disabled") then return end
	if IsAddOnLoaded("ElvUI") then TinyDPSSkinButton:Disable() TinyDPSSkinButton.text:SetText("|cFF808080TinyDPS Skin Disabled for ElvUI|r") return end
	if not (IsAddOnLoaded("TinyDPS") and IsAddOnLoaded("Tukui")) then return end
	local frame = tdpsFrame
	local anchor = tdpsAnchor
	local status = tdpsStatusBar
	local tdps = tdps
	local font = tdpsFont
	local position = tdpsPosition
	local button = TukuiRaidUtilityShowButton

	if( tdps ) then
		tdps.width = TukuiMinimap:GetWidth()
		tdps.spacing = 2
		tdps.barHeight = 14
		font.name = c["media"].pixelfont
		font.size = 12
		font.outline = "MONOCHROMEOUTLINE"
	end

	anchor:Point( "BOTTOMLEFT", TukuiMinimap, "BOTTOMLEFT", 0, -26 )

	frame:SetWidth( TukuiMinimap:GetWidth() )

	position = { x = 0, y = -6 }

	frame:SetTemplate( "Transparent", true )
	frame:CreateShadow( "Default" )
	
	if( status ) then
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
		tdpsStatusBar:SetStatusBarTexture( c["media"].normTex )
	end

	if( button ) then
		button:HookScript( "OnShow", function( self ) 
			anchor:ClearAllPoints()
			anchor:Point( "BOTTOMLEFT", TukuiMinimap, "BOTTOMLEFT", 0, -49 )
		end )
		button:HookScript( "OnHide", function( self ) 
			anchor:ClearAllPoints()
			anchor:Point( "BOTTOMLEFT", TukuiMinimap, "BOTTOMLEFT", 0, -26 )
		end )
	end
end )