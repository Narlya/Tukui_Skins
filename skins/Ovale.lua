if not (IsAddOnLoaded("Tukui") or IsAddOnLoaded("AsphyxiaUI") or IsAddOnLoaded("DuffedUI")) then return end
local AS = unpack(select(2,...))

local name = "OvaleSkin"
function AS:SkinOvale()
	AS:Delay(5, function()
		if not Icon1n1 then return end
		Icon1n1:GetParent():StripTextures()
		for i = 1, 10 do
			if not _G["Icon"..i.."n1"] then return end
			AS:SkinBackdropFrame(_G["Icon"..i.."n1"], true)
			_G["Icon"..i.."n1"].Backdrop:SetFrameLevel(0)
			_G["Icon"..i.."n1"].Backdrop:SetAllPoints()
			_G["Icon"..i.."n1"].Backdrop:SetScale(AS.UIScale)
			_G["Icon"..i.."n1"].icone:SetDrawLayer("OVERLAY")
			_G["Icon"..i.."n1"].icone:SetTexCoord(0.12, 0.88, 0.12, 0.88)
			_G["Icon"..i.."n1"].icone:SetInside(_G["Icon"..i.."n1"].Backdrop, 1, 1)
		end
	end)
end

AS:RegisterSkin(name, AS.SkinOvale)