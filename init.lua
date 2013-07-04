if not (IsAddOnLoaded("Tukui") or IsAddOnLoaded("AsphyxiaUI") or IsAddOnLoaded("DuffedUI")) then return end
local A, C, L = unpack(Tukui or AsphyxiaUI or DuffedUI)
local AddOnName, Engine = ...
local AddOn = {};
AddOn.FrameLocks = {}

Engine[1] = AddOn
UISkins = Engine

AddOn.A = A
AddOn.C = C
AddOn.Version = GetAddOnMetadata(AddOnName, "Version")
AddOn.Title = select(2, GetAddOnInfo(AddOnName))
AddOn.Blank = C["Media"].Blank
AddOn.NormTex = C["Media"].Normal
AddOn.Font = C["Media"].Font
AddOn.UFFont = C["Media"].AltFont
AddOn.PixelFont = C["Media"].PixelFont
AddOn.ActionBarFont = C["Media"].ActionBarFont
AddOn.UIScale = C["General"].UIScale
AddOn.MyClass = select(2, UnitClass("player"))
AddOn.MyName = UnitName("player")
AddOn.MyRealm = GetCVar("realmName")
AddOn.Noop = function() return end
AddOn.DataTextFontSize = C["DataText"] and C["DataText"].FontSize or 12
AddOn.BorderColor = C["Media"].BorderColor

AddOn.InfoLeft = A.Panels.DataTextLeft
AddOn.InfoRight = A.Panels.DataTextRight
AddOn.ChatBackgroundRight = A.Panels.RightChatBackground
AddOn.ChatBackgroundLeft = A.Panels.LeftChatBackground
AddOn.TabsRightBackground = A.Panels.RightChatTabsBackground
AddOn.TabsLeftBackground = A.Panels.LeftChatTabsBackground
AddOn.Minimap = A.Minimap
--AddOn.Tooltip = A.Tooltips.GameTooltip.Anchor
AddOn.ActionBar1 = A.Panels.ActionBar1
AddOn.ActionBar2 = A.Panels.ActionBar2
AddOn.ActionBar3 = A.Panels.ActionBar3
AddOn.ActionBar4 = A.Panels.ActionBar4