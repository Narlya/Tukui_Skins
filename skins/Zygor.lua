if not (IsAddOnLoaded("Tukui") or IsAddOnLoaded("AsphyxiaUI") or IsAddOnLoaded("DuffedUI")) then return end
local AS = unpack(select(2,...))

local name = "ZygorSkin"
function AS:SkinZygor()
	ZygorGuidesViewerFrame:StripTextures(True)
	AS:SkinFrame(ZygorGuidesViewerFrame_Border)
	AS:SkinFrame(ZygorGuidesViewer_CreatureViewer, true)

	for i = 1, 6 do
		AS:SkinBackdropFrame(_G["ZygorGuidesViewerFrame_Step"..i])
	end

	if ZygorGuidesViewerFrame:IsShown() then AS:SkinFrame(ZygorGuidesViewerFrame_Border) end
	ZygorGuidesViewerFrame_Border:HookScript("OnHide", function(self) self:StripTextures(True) end)
	ZygorGuidesViewerFrame_Border:HookScript("OnShow", function(self) AS:SkinFrame(self) end)
end

AS:RegisterSkin(name, AS.SkinZygor)